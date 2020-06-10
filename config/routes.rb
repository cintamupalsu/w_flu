Rails.application.routes.draw do

  get 'api/login'
  get 'api/heatmap'

  root 'freeaccess_pages#home'
  get '/help', to: 'freeaccess_pages#help'
  get '/about', to: 'freeaccess_pages#about'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/add_positions_file', to: 'positions#add_file'
  post '/upload_position_file', to: 'positions#upload_file'
  get '/delete_all_positions', to: 'positions#delete_all'

  resources :users
end
