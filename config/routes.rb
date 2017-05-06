Rails.application.routes.draw do
  
  root "restaurants#index"

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :restaurants
  # resources :reservations
  resources :users
end
