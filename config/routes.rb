Rails.application.routes.draw do
  root to: 'slack#login'
  get 'info', to: 'slack#info'
  get '/auth/slack/callback', to: 'sessions#create'

  resources :teams, only: :show
end
