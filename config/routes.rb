Rails.application.routes.draw do

  root 'static_pages#home'
  
  get  'static_pages/home'
  get  'static_pages/contact'
  get  'static_pages/about'

  get  '/signup',  to: 'users#new'

  resources :posts
  resources :users

end
