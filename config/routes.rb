Rails.application.routes.draw do

  get 'sessions/new'

  root 'static_pages#home'

  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :posts, only: [:create, :destroy]
  resources :users

	namespace :api do
	  #devise_scope :user do
	  post 'sessions' => 'sessions#create', :as => 'login'
	  delete 'sessions' => 'sessions#destroy', :as => 'logout'
	  #end
	  resources :users, :defaults => { :format => 'json' }
	  resources :posts, only: [:index, :create, :show, :update, :destroy], :defaults => { :format => 'json' }
  end
end
