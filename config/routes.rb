Rails.application.routes.draw do

  resources :users
  resources :playlists
  resources :songs

  root "welcome#home"

  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
  get '/singin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  
end
