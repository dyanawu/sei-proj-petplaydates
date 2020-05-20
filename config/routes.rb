Rails.application.routes.draw do
  devise_for :users
  # uncomment below when we're ready
  # before_action :authenticate_user!
  root to: "events#index"
  resources :events
  post '/events/:id/rsvp', to: 'events#rsvp', as: "rsvp"

  resources :pets

  get '/users', to: "users#index"
  get '/users/:id', to: "users#show", as: 'user'
end
