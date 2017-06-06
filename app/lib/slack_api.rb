class SlackAPI
  BASE_URL = 'https://slack.com/api'.freeze

  def initialize(token)
    @token = token
  end

  def users_list
    request 'members', 'users.list', count: 1000
  end

  def channels_list
    request 'channels', 'channels.list', count: 1000
  end

  def channel_messages(id)
    request 'messages', 'channels.history', channel: id, count: 1000
  end

  private

  def request(key, url, data = {})
    body = authorized_request url, data
    return body[key] if body['ok']
    raise SlackApiError, body.to_s
  end

  def authorized_request(url, data)
    base_request url, data.merge(token: @token)
  end

  def base_request(url, data)
    response = Faraday.post(File.join(BASE_URL, url)) do |faraday|
      faraday.params = data
    end
    JSON.parse(response.body)
  end
end

class SlackApiError < StandardError; end
