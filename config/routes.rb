Rails.application.routes.draw do

    root 'home#index'

    namespace :admin do

    	root 'home#index'
    	
  		resources :categories

		end

		resources :users, only: [:new, :create, :show]
		resources :sessions, only: [:new, :create, :destroy]

  	get '/signup',  to: 'users#new', as: :signup
		get '/login', to: 'sessions#new', as: :login
		post '/login', to: 'sessions#create'
		get '/logout', to: 'sessions#destroy', as: :logout
    
end
