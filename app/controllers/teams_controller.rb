class TeamsController < ApplicationController
  def show
    @team = current_team
    @channels = @team.channels
    @users = @team.users
  end

  def export
    team = Team.find params[:id]
    filename = Rails.root.join('tmp', "#{team.name}-#{Time.now.to_i}.xlsx")
    row = %w(User Channel Date DateTime)

    data = team.messages.map do |message|
      [
        message.user.name,
        message.channel.name,
        message.created_at.strftime('%d/%m/%Y'),
        message.created_at.strftime('%d/%m/%Y %H:%M')
      ]
    end

    ExcelImporter.new(filename, row, data)
    send_file filename
  end

  def destroy
    team = Team.find params[:id]
    team.destroy
    redirect_to root_url
  end

  private

  def current_team
    Team.find_by_slack_id(session[:team]) if session[:team]
  end
end
