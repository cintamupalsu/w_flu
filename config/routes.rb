Rails.application.routes.draw do
  get 'freeaccess_pages/home'
  get 'freeaccess_pages/help'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
