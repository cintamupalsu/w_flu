Rails.application.routes.draw do

  get 'calendars/index'
  resources :reportsheets
  get 'api/login'
  get 'api/heatmap'
  get 'api/idokeireport'
  post 'api/postposition'
  get 'api/getcomment'

  root 'freeaccess_pages#home'
  get '/help', to: 'freeaccess_pages#help'
  get '/about', to: 'freeaccess_pages#about'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/add_positions_file', to: 'positions#add_file'
  get '/dmap', to: 'positions#dmap'
  post '/upload_position_file', to: 'positions#upload_file'
  get '/delete_all_positions', to: 'positions#delete_all'

  get 'calendars_view', to: 'calendars#index'
  get 'calendar_prev_month', to: 'calendars#index'
  get 'calendar_prev_years', to: 'calendars#index'
  get 'calendar_next_month', to: 'calendars#index'
  get 'calendar_next_years', to: 'calendars#index'

  resources :users
  resources :microposts, only: [:create, :destroy]
end
