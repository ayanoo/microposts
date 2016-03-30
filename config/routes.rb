Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/microposts/retweet/:original_id', to: 'microposts#retweet', as: 'retweet'

  #get   'followings', to:'users#followings'
  #get "/users/followings/:id" => "users#followings", :as => :followings
  #get   'followers', to:'users#followers'
  
  resources :users do
    member do
      get :followings, :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts 
  
  resources :relationships, only: [:create, :destroy]
  
  resources :likes, only: [:create, :destroy]
end
