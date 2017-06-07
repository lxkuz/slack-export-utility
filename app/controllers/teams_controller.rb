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
    filename = Rails.root.join('tmp', "#{current_team.name}-#{Time.now.to_i}.csv")
    exporter = ExcelImporter.new filename, export_columns
    current_team.messages.preload(:user).preload(:channel).find_in_batches do |batch|
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
