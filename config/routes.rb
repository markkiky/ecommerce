Rails.application.routes.draw do

  devise_for :admins 
  resources :order_items
  resources :orders
  resources :categories
  resources :products
  # devise_for :customers
  resources :customers
  resources :homes
  devise_for :customers
  root "homes#index"
  delete '/logout', to: 'sessions#destroy'


  get '/admin/dashboard', to: "admins#dashboard"
  # Twitter path
  get '/auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
