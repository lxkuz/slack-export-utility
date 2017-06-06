require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let(:team) do
    Team.create name: 'teamtest', slack_id: 'team1', token: 'test'
  end

  let(:user) do
    User.create team: team, name: 'usertest', slack_id: 'user1'
  end

  let(:channel) do
    Channel.create team: team, name: 'channeltest', slack_id: 'channel1'
  end

  let(:message) do
    Message.create team: team,
                   channel: channel,
                   user: user,
                   slack_id: 'message1'
  end

  describe 'GET #inde' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      expect(team.id).not_to be_nil
      expect(message.id).not_to be_nil

      get :show, params: { id: team.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #export' do
    it 'responds successfully with an HTTP 200 status code' do
      expect(team.id).not_to be_nil
      expect(message.id).not_to be_nil

      get :export, params: { id: team.id }
      expect(response).to be_success
      expect(response.headers['Content-Type']).to eq('application/octet-stream')
    end
  end

  describe 'DELETE #destroy' do
    it 'responds successfully with an redirect to root url' do
      expect(team.id).not_to be_nil
      expect(message.id).not_to be_nil

      delete :destroy, params: { id: team.id }
      expect(response).to redirect_to(teams_url)
    end
  end
end
