Rails.application.routes.draw do

  resources :users do
    resources :playlists, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :songs, only: [:index]
  end
  resources :playlists, only: [:index]

  resources :songs
  get '/songs/:attribute/:name', to: 'songs#index'

  get '/auth/facebook/callback', to: 'sessions#create'


  root "welcome#home"

  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"

  post '/delete', to: "playlists#destroy"

end
