class TeamsController < ApplicationController
  def show
    @team = current_team
    @channels = @team.channels
    @users = @team.users
  end

  private

  def current_team
    Team.find_by_slack_id(session[:team]) if session[:team]
  end
end
