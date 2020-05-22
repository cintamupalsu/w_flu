Rails.application.routes.draw do

  root 'freeaccess_pages#home'
  get '/help', to: 'freeaccess_pages#help'
  get '/about', to: 'freeaccess_pages#about'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
end
