Rails.application.routes.draw do
  root 'freeaccess_pages#home'
  get '/help', to: 'freeaccess_pages#help'
  get '/about', to: 'freeaccess_pages#about'
end
