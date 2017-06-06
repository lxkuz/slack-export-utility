class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    team = Team.find_or_create_from_slack auth
    team.export!
    redirect_to team_url(team.id)
  end
end
