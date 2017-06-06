class SlackExporter
  BATCH_SIZE = 30

  def initialize(team)
    @team = team
    @api_client = SlackAPI.new team.token
  end

  def export_team!
    export_users!
    export_channels!
    export_messages!
  end

  def export_users!
    data = @api_client.users_list
    fields = { name: 'name' }
    User.bulk_insert do |worker|
      worker.set_size = BATCH_SIZE
      export_collection! User, worker, data, fields, clean: true
    end
  end

  def export_channels!
    data = @api_client.channels_list
    fields = { name: 'name' }
    Channel.bulk_insert do |worker|
      worker.set_size = BATCH_SIZE
      export_collection! Channel, worker, data, fields, clean: true
    end
  end

  def export_messages!
    clean_collection! Message
    users_map = {}
    Message.bulk_insert do |worker|
      worker.set_size = BATCH_SIZE
      @team.users.each do |user|
        users_map[user.slack_id] = user.id
      end
      @team.channels.each do |channel|
        export_channel_messages! worker, channel, users_map
      end
    end
  end

  def export_channel_messages!(worker, channel, users_map)
    messages_data = @api_client.channel_messages channel.slack_id
    messages_data.select! { |o| o['user'] }
    messages_data.each do |obj|
      obj['channel_id'] = channel.id
      obj['user_id'] = users_map[obj['user']]
    end
    fields = { user_id: :user_id, channel_id: :channel_id }
    export_collection! Message, worker, messages_data, fields, clean: false
  end

  private

  def clean_collection!(klass)
    klass.where(team_id: @team.id).delete_all
  end

  def export_collection!(klass, worker, data, fields, options = {})
    clean_collection! klass if options[:clean]
    data.each do |record|
      export_record! klass, worker, record, fields
    end
  end

  def export_record!(_klass, worker, record, fields)
    attrs = { team_id: @team.id, slack_id: record['id'], created_at: parse_ts(record) }
    fields.each do |from, to|
      attrs[to] = record[from.to_s]
    end
    worker.add attrs
  end

  def parse_ts(record)
    ts = record['ts'] || record['updated'] || record['created']
    DateTime.strptime ts.to_s, '%s'
  end
end
