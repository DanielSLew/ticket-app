Rails.application.routes.draw do
  root to: 'projects#index'

  get '/signup',    to: 'users#new'
  post '/signup',   to: 'users#create'
  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :tickets do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :projects
  resources :tags, except: [:show]
end
