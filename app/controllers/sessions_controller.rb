class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    team = Team.find_or_create_from_slack auth
    team.export!
    session[:team] = team.slack_id
    redirect_to team_url(team.id)
  end

  def destroy
    session[:team] = nil
    redirect_to root_url
  end
end
