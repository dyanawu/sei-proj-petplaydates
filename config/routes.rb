Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # uncomment below when we're ready
  # before_action :authenticate_user!
  root to: "events#index"
  resources :events
  resources :pets
end
