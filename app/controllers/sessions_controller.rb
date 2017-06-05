class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    session[:token] = auth['credentials']['token']
    session[:team] = auth['info']['team']
    session[:username] = auth['info']['name'] || auth['info']['nickname']
    redirect_to controller: :slack, action: :info
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed out!'
  end
end
