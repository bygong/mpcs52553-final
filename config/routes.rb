Rails.application.routes.draw do
  
  root "restaurants#index"

  # get '/users' => 'users#new'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/reservations/all' => 'reservations#all'
  get '/restaurants/:id/all_reservation' => 'restaurants#all_reservation'
  
  get '/statistics' => 'restaurants#stat'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # get 'auth/:provider/callback' => 'sessions#create_auth'
  # post 'auth/:provider/callback' => 'sessions#create_auth'
  # get 'auth/failure' => redirect('/')
  # post 'auth/failure' => redirect('/')

  resources :restaurants
  resources :reservations
  resources :users

end
