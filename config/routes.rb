Rails.application.routes.draw do

  root "welcome#home"

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/singup', to: "users#new"
  post '/signin', to: "users#create"
  get '/logout', to: "sessions#destroy"

  resources :users
  resources :playlists
  resources :songs
end
