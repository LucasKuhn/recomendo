Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users do
    resources :follows
    resource :followers
    resource :followings
  end
  resources :tags
  resources :categories
  resources :posts do
    resources :likes
    member do
      get :read_more
    end
  end

  namespace :search do
    get :users
    get :posts
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/home', to: 'application#home'
  get '/welcome', to: 'application#welcome'

  authenticated :user do
    root to: 'posts#index', as: :authenticated_user_root
  end

  root to: 'home#show'

  namespace :cors do
    get 'get_title'
  end

  # Service Worker Routes
  get '/service-worker.js' => "service_worker#service_worker"
  get '/manifest.json' => "service_worker#manifest"
end
