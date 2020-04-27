Rails.application.routes.draw do
  get 'users/new'
  root 'freeaccess_pages#home'
  get '/help', to: 'freeaccess_pages#help'
  get '/about', to: 'freeaccess_pages#about'
  
  get '/signup', to: 'users#new'
end
