Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :gedcoms do
    member do
      get :birthplaces, :rollup
    end
  end
  resources :users
  resources :sessions,      :only => [:new, :create, :destroy]
  resources :microposts,    :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :gedcoms,       :only => [:new, :create, :show, :destroy]
   
  match '/signup',  :to => 'users#new', :via => [:get]
  match '/signin',  :to => 'sessions#new', :via => [:get]
  match '/signout', :to => 'sessions#destroy', :via => [:delete]

  match '/contact', :to => 'pages#contact', :via => [:get]
  match '/about',   :to => 'pages#about', :via => [:get]
  match '/help',    :to => 'pages#help', :via => [:get]

  root :to => 'pages#home'
end
