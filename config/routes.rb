Rails.application.routes.draw do
  devise_for :admins 
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
  get "/change_image", to: "products#change_product"
  root "homes#index"
  # admin routes
  get '/admin/dashboard', to: "admins#dashboard", as: :admin_dashboards

  #notification routes
  get 'contact', to: 'homes#new', as: :contact
  post 'contact', to: 'homes#create'

  get 'payment/:id', to: 'orders#order_payment', as: :order_payment
  post '/mpesa_push/:id', to: "orders#send_push", as: :send_push


  get "/check_payment/:id", to: "orders#check_payment", as: :check_payment 
  
  # catgory paths
  resources :categories
  # mount ActionCable.server => '/cable'
  
  #products path
  resources :products do 

    #reviews routes
    resources :reviews 
    
  end 

  # Add color ajax
  get "/add_color", to: 'categories#add_color', as: :add_color
  get "/remove_color", to: "categories#remove_color", as: :remove_color

  # devise_for :customers
  resources :customers
  resources :homes
  devise_for :customers, :path => "users"

  get '/logout', to: 'sessions#destroy'
  get '/users', to: "devise/registrations#new"

  post '/product_counter', to: "products#product_counter"
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

  #admin order orders#admin_order
  get '/admin_order', to: 'orders#admin_order', as: :admin_order
  get "/order_product", to: "orders#order_product"
  get "/get_price", to: "orders#get_price"
  post '/admin/place_order', to: "orders#create_admin_order", as: :admin_place_order



  #search path
  get "search", to: "products#search"

  #wishlist path
  get "wishlists/update"
  get "/wishlists", to: "wishlists#index"
  delete 'wishlists/:id(.:format)', :to => 'wishlists#destroy'

end
