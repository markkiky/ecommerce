Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "homes#index"

  # admin routes
  devise_for :admins 
  get '/admin/dashboard', to: "admins#dashboard", as: :admin_dashboard
 
  # catgory paths
  resources :categories

  #products path
  resources :products

  # devise_for :customers
  resources :customers
  resources :homes
  devise_for :customers, :path => "users"
  delete '/logout', to: 'sessions#destroy'
  get '/users', to: "devise/registrations#new"


  # Twitter path
  get '/auth/:provider/callback', to: 'sessions#omniauth'

  #cart routes 
  resources :order_items, path: '/cart/items'
  get '/cart', to: 'order_items#index'
  get '/cart/checkout', to: 'orders#new', as: :checkout
  patch '/cart/checkout', to: 'orders#create'
  get '/checkout/order_success', to: 'orders#order_success', as: :order_success

  # order paths
  resources :orders

  #search path
  get "search", to: "products#search"

end
