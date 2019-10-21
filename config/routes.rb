Rails.application.routes.draw do
  resources :followers, only: [:show, :create]
  resources :polls
  resources :users, except: [:edit, :update, :destroy]
  resources :votes, only: [:create]
  resources :comments, only: [:create]

  root "polls#index"


  get '/login', to: 'sessions#new' #form
  post '/sessions', to: 'sessions#create' #log the user in
  get '/logout', to: 'sessions#destroy'
  get '/users/:id/leaderboard', to: 'users#leaderboard', as: 'leaderboard'
  get '/users/:id/upgrade', to: 'users#upgrade', as: 'upgrade'
  post '/polls/filter', to: 'polls#filter', as: 'filter'

end
