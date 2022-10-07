Rails.application.routes.draw do
  get 'friendships/create'
  get 'friendships/destroy'
  resources :user_stocks
  get 'my_portfolio' , to:'users#my_portfolio'
  get 'search_stock', to: "stocks#search"

  devise_for :users
  root "welcomes#index"
  get 'welcomes/index'
  get 'my_friend', to: "users#my_friends"
  get 'search_friend', to:"users#search"
  resources :friendships
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
