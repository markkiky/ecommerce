Rails.application.routes.draw do
  resources :order_items
  resources :orders
  resources :categories
  resources :products
  # devise_for :customers
  resources :customers
  resources :homes
  devise_for :customers, :controllers => { :registrations => 'registrations' }, :path => '/users' , :path_names => { :sign_in => 'sign_in', :sign_up => 'sign_up', :sign_out => 'sign_out', :password => '/', :confirmation => 'verification' }
  root "homes#index"
  delete '/logout', to: 'sessions#destroy'

  # Twitter path
  get '/auth/:provider/callback', to: 'sessions#create'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
