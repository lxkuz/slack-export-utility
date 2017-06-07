class TeamsController < ApplicationController
  include TeamExporter

  def index
    @teams = Team.all
    @url = URI::HTTPS.build(host: 'slack.com',
                            path: '/oauth/authorize',
                            query: {
                              scope: 'users:read,channels:read,channels:history',
                              client_id: ENV['API_KEY'],
                              redirect_uri: ENV['REDIRECT_URI']
                            }.to_query).to_s
  end

  def show
    @channels = current_team.channels
    @users = current_team.users
  end

  def export
    if current_team.file
      file = current_team.file
      if File.exist?(file)
        send_file file
        return
      end
    end
    filename = Rails.root.join('tmp', "#{current_team.name}-#{Time.now.to_i}.csv")
    current_team.file = filename
    current_team.save
    exporter = ExcelImporter.new filename, export_columns
    batch_size = ENV['BATCH_SIZE'].to_i
    current_team.messages.preload(:user).preload(:channel).find_in_batches(batch_size: batch_size) do |batch|
      data = export_data batch
      exporter.append data
    end
    send_file filename
  end

  def destroy
    current_team.destroy
    redirect_to teams_url
  end

  private

  def current_team
    @team ||= Team.find params[:id]
  end
end
