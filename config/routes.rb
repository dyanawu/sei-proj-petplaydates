Rails.application.routes.draw do
  devise_for :users
  # uncomment below when we're ready
  # before_action :authenticate_user!
  root to: "events#index"
  resources :events
  resources :pets
end
