class SlackController < ApplicationController
  def login; end

  def info
    client = SlackAPI.new session[:token]
    @username = session[:username]
    @team = session[:team]
    @users = client.users_list
    @channels = client.channels_list
  end
end
