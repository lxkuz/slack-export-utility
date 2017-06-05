class SlackController < ApplicationController
  def login
    @url = URI::HTTPS.build(host: 'slack.com',
                            path: '/oauth/authorize',
                            query: {
                              scope: 'users:read,channels:read,channels:history',
                              client_id: ENV['API_KEY'],
                              redirect_uri: ENV['REDIRECT_URI']
                            }.to_query).to_s
  end

  def info
    client = SlackAPI.new session[:token]
    @username = session[:username]
    @team = session[:team]
    @users = client.users_list
    @channels = client.channels_list
    @messages = {}
    @channels.each do |channel|
      @messages[channel['id']] = client.channel_messages channel['id']
    end
  end
end
