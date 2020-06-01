Rails.application.routes.draw do

  get 'api/login'
  root 'freeaccess_pages#home'
  get '/help', to: 'freeaccess_pages#help'
  get '/about', to: 'freeaccess_pages#about'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
