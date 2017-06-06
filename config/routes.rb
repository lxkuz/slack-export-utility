Rails.application.routes.draw do
  get '/auth/slack/callback', to: 'sessions#create'

  resources :teams, only: [:index, :show, :destroy], path: '/' do
    member do
      get 'export'
    end
  end
end
