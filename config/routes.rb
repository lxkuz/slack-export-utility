Rails.application.routes.draw do
  root to: 'slack#login'
  get '/auth/slack/callback', to: 'sessions#create'

  resources :teams, only: [:show, :destroy] do
    member do
      get 'export'
    end
  end
end
