Rails.application.routes.draw do

  devise_for :admins 
  resources :order_items
  resources :orders
  resources :categories
  resources :products
  # devise_for :customers
  resources :customers
  resources :homes
  devise_for :customers, :path => "users"
  root "homes#index"
  delete '/logout', to: 'sessions#destroy'
  
  get '/users', to: "devise/registrations#new"

  get '/admin/dashboard', to: "admins#dashboard", as: :admin_dashboard
  
  # Twitter path
  get '/auth/:provider/callback', to: 'sessions#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
