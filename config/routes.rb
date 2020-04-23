Rails.application.routes.draw do
  root 'freeaccess_pages#home'
  get 'freeaccess_pages/home'
  get 'freeaccess_pages/help'
  get 'freeaccess_pages/about'
end
