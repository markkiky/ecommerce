Rails.application.routes.draw do

  resources :complete_orders
  resources :colors
  resources :sizes
  resources :transactions
  post 'transactions/mpesa', to: 'transactions#mpesa_transcation_callback', as: :mpesa_callback
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  authenticated :admin do
    root :to => "admins#dashboard", as: :admin_dashboard
    get '/admins/sign_out' => 'devise/sessions#destroy'
  end
  root "homes#index"
  # admin routes
  devise_for :admins  do
    
  end
  get '/admin/dashboard', to: "admins#dashboard", as: :admin_dashboards
  get '/contact_us/', to: 'homes#contact_us', as: :contact_us

  get 'payment/:id', to: 'orders#order_payment', as: :order_payment
  get '/mpesa_push/:id', to: "orders#send_push", as: :send_push

  get "/check_payment/:id", to: "orders#check_payment", as: :check_payment 
  
  # catgory paths
  resources :categories
  # mount ActionCable.server => '/cable'
  #products path
  resources :products

  # devise_for :customers
  resources :customers
  resources :homes
  devise_for :customers, :path => "users", controllers: { omniauth_callbacks: 'customers/omniauth' }

  get '/logout', to: 'sessions#destroy'
  get '/users', to: "devise/registrations#new"


  # Customers Social Logins path
  # get 'auth/google_oauth/callback', to: 'sessions#customer_omniauth'
  # get 'auth/admin/callback', to: 'sessions#customer_omniauth'
  get 'auth/:provider/callback', to: 'sessions#omniauth'

  #cart routes 
  resources :order_items, path: '/cart/items'
  get '/cart', to: 'order_items#index'
  get '/cart/checkout', to: 'orders#new', as: :checkout
  patch '/cart/checkout', to: 'orders#create'
  get 'order_success/:id', to: 'orders#order_success', as: :order_success

  # order paths
  resources :orders

  #search path
  get "search", to: "products#search"

  #wishlist path
  get "wishlists/update"
  get "/wishlists", to: "wishlists#index"

end
