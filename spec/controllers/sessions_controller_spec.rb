require 'rails_helper'
require 'mock_data/slack_api'

def stub_slack_request(token, url, data, params = nil)
  uri = URI.parse(SlackAPI::BASE_URL)
  uri.path += "/#{url}"
  uri.query = "count=1000&token=#{token}"
  uri.query += "&#{params}" if params
  stub_request(:post, uri.to_s).with(headers: {
                                       'Accept' => '*/*',
                                       'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                                       'Content-Length' => '0',
                                       'User-Agent' => 'Faraday v0.11.0'
                                     })
                               .to_return(status: 200, body: data, headers: {})
end

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    it 'responds successfully with an HTTP 200 status code' do
      token = 'testtoken'
      # users list
      users_data = SlackApiMockData.users_list
      stub_slack_request token, 'users.list', users_data

      # channels list
      channels_data = SlackApiMockData.channels_list
      stub_slack_request token, 'channels.list', channels_data

      # channel history
      channel_history = SlackApiMockData.channel_history
      channel_id = SlackApiMockData.channel_id
      stub_slack_request token, 'channels.history', channel_history, "channel=#{channel_id}"

      auth = {
        'credentials' => {
          'token' => token
        },
        'info' => {
          'team_id' => 'team1',
          'team' => 'testteam'
        }
      }
      request.headers['omniauth.auth'] = auth
      post :create, params: {}
      team = Team.last
      expect(response).to redirect_to(team_url(team))
    end
  end
end
