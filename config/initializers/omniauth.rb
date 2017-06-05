Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['API_KEY'], ENV['API_SECRET'], scope: 'users:read', provider_ignores_state: true
end
