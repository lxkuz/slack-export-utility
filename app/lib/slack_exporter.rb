class SlackExporter
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
    export_collection! User, data, fields, clean: true
  end

  def export_channels!
    data = @api_client.channels_list
    fields = { name: 'name' }
    export_collection! Channel, data, fields, clean: true
  end

  def export_messages!
    clean_collection! Message
    @team.channels.each do |channel|
      export_channel_messages! channel
    end
  end

  def export_channel_messages!(channel)
    messages_data = @api_client.channel_messages channel.slack_id
    messages_data.each do |obj|
      obj['channel_id'] = channel.id
      obj['user_id'] = User.where(team: @team).find_by_slack_id(obj['user']).id
    end
    fields = {
      user_id: :user_id,
      channel_id: :channel_id
    }
    export_collection! Message, messages_data, fields, clean: false
  end

  private

  def clean_collection!(klass)
    klass.where(team_id: @team.id).delete_all
  end

  def export_collection!(klass, data, fields, options = {})
    clean_collection! klass if options[:clean]
    data.each do |record|
      export_record! klass, record, fields
    end
  end

  def export_record!(klass, record, fields)
    puts 'RECORD:'
    puts record
    obj = klass.new team_id: @team.id, slack_id: record['id'], created_at: parse_ts(record)
    fields.each do |from, to|
      obj.send("#{to}=", record[from.to_s])
    end
    obj.save!
  end

  def parse_ts(record)
    ts = record['ts'] || record['updated'] || record['created']
    puts 'TS ' + ts.to_s
    DateTime.strptime ts.to_s, '%s'
  end
end
