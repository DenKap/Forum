Rails.application.routes.draw do

    root 'home#index'


		resources :users
		resources :sessions, only: [:new, :create, :destroy]

  	get '/signup',  to: 'users#new', as: :signup
		get '/login', to: 'sessions#new', as: :login
		post '/login', to: 'sessions#create'
		get '/logout', to: 'sessions#destroy', as: :logout

  	resources :categories, only: :show do
      resources :topics, except: :index
    end

    resources :topics, except: :index do
      resources :posts, except: [:index, :show, :new]
    end

    namespace :admin do

    	root 'categories#index'
    	
  		resources :categories

		end
    
end
