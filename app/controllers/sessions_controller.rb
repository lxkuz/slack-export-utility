class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    request.headers.each { |key, _value| puts key }
    team = Team.find_or_create_from_slack auth
    team.export!
    redirect_to team_url(team.id)
  end
end
