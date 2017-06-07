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

  def _ts(record)
    record['ts'] || record['updated'] || record['created']
  end

  def request(key, url, options = {}, data = [])
    body = authorized_request url, options
    raise SlackApiError, body.to_s unless body['ok']
    data += body[key]
    return data unless body['has_more']
    options['latest'] = _ts(data.last)
    request key, url, options, data
  end

  def authorized_request(url, options)
    base_request url, options.merge(token: @token)
  end

  def base_request(url, data)
    response = Faraday.post(File.join(BASE_URL, url)) do |faraday|
      faraday.params = data
    end
    JSON.parse(response.body)
  end
end

class SlackApiError < StandardError; end
