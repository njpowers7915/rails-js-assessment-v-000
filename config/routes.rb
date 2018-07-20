Rails.application.routes.draw do

  root "welcome#home"

  get '/login', to: "users#new"
  post '/login', to: "users#create"
  get '/singup', to: "sessions#new"
  post '/signin', to: "sessions#create"
  get '/logout', to: "sessions#destroy"

  resources :users
  resources :playlists
  resources :songs
  #resources :users
  #resources :rides
  #resources :attractions
end
