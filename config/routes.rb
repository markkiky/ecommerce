Rails.application.routes.draw do
  require "sidekiq/web"
  require "sidekiq-status/web"
  mount Sidekiq::Web, at: "/sidekiq"

  get "orders/completed", to: "orders#after_check_payment"
  devise_for :admins,
             path_name: {
               #  removes admins sign up path
               sign_up: "",
             }
  resources :complete_orders
  resources :colors
  resources :sizes
  resources :transactions
  post "transactions/mpesa", to: "transactions#mpesa_transcation_callback", as: :mpesa_callback
  # post 'transactions/card', to: 'transactions#card_transaction_callback', as: :card_callback
  post "transactions/card", to: "transactions#card"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  authenticated :admin do
    root :to => "admins#dashboard", as: :admin_dashboard
    get "/admins/sign_out" => "devise/sessions#destroy"
  end

  devise_scope :admin do
    get "/admins", to: "devise/registrations#new"
    get "/admins/sign_out" => "devise/sessions#destroy"
    get "/admins/list", to: "admins#index", as: :admins_list
    get "/admins/list/:id", to: "admins#show", as: :show_admin
    get "/admins/list/orders/:id", to: "admins#show_admin_orders", as: :show_admin_orders
    get "/admins/new", to: "admins#add_admin", as: :add_admin
    post "/admins/create", to: "admins#create_admin"

    get "/customers/list/:id", to: "admins#show_customer", as: :show_customer
    get "/customers/list/orders/:id", to: "admins#show_customer_orders", as: :customer_orders
    get "/customers/new", to: "admins#add_customer", as: :add_customer
    post "/customers/create", to: "admins#create_customer"
    get "/logout", to: "sessions#destroy"
  end
  get "/change_image", to: "products#change_product"
  root "homes#index"
  # admin routes
  get "/admin/dashboard", to: "admins#dashboard", as: :admin_dashboards

  #notification routes
  get "contact", to: "homes#new", as: :contact
  post "contact", to: "homes#create"

  get "payment/:id", to: "orders#order_payment", as: :order_payment
  post "/mpesa_push/:id", to: "orders#send_push", as: :send_push

  get "/check_payment/:id", to: "orders#check_payment", as: :check_payment

  #card payment path
  get "card", to: "orders#card_payment", as: :card

  get "subcategories", to: "products#get_sub_categories", as: :get_sub_categories

  # catgory paths
  resources :categories
  mount ActionCable.server => "/cable"

  #products path
  resources :products do

    #reviews routes
    resources :reviews
  end
  get "/admin/products", to: "products#index_admin"

  # Add color ajax
  get "/add_color", to: "categories#add_color", as: :add_color
  get "/add_size", to: "categories#add_size", as: :add_size
  get "/remove_color", to: "categories#remove_color", as: :remove_color

  # devise_for :customers
  resources :customers
  resources :homes
  devise_for :customers, :path => "users"

  get "/choose_payment/:id", to: "orders#choose_payment", as: :choose_payment
  post "/choose_payment/:id", to: "orders#admin_payment", as: :admin_payment
  devise_scope :customer do
    
    get "/users", to: "devise/registrations#new"
  end
  # post '/admin_payment', to: "orders#admin_payment", as: :admin_payment
  post "/product_counter", to: "products#product_counter"
  # Customers Social Logins path
  # get 'auth/google_oauth/callback', to: 'sessions#customer_omniauth'
  # get 'auth/admin/callback', to: 'sessions#customer_omniauth'
  get "auth/:provider/callback", to: "sessions#omniauth"

  #cart routes
  resources :order_items, path: "/cart/items"
  get "/cart", to: "order_items#index"
  get "/cart/checkout", to: "orders#new", as: :checkout
  # post '/cart/checkout', to: 'orders#new', as: :guest_checkout
  patch "/cart/checkout", to: "orders#create"
  post "/cart/checkout", to: "orders#create"
  get "order_success/:id", to: "orders#order_success", as: :order_success
  get "order_success_admin/:id", to: "admins#order_success_admin", as: :order_success_admin

  # order paths
  resources :orders
  get "dispatch/:id", to: "orders#dispatcher", as: :dispatcher
  get "delivered/:id", to: "orders#delivered", as: :delivered

  #admin order orders#admin_order
  get "/admin_order", to: "orders#admin_order", as: :admin_order
  get "/order_product", to: "orders#order_product"
  get "/get_price", to: "orders#get_price"
  post "/admin/place_order", to: "orders#create_admin_order", as: :admin_place_order
  get "/order_history", to: "orders#order_history", as: :order_history
  get "admin_order_history", to: "admins#admin_order_history", as: :admin_order_history
  get "sold/products", to: "admins#sold_product", as: :sold_products

  #search path
  get "search", to: "products#search"
  post "search", to: "homes#advanced_search", as: :advanced_search

  #wishlist path
  get "wishlists/update"
  get "/wishlists", to: "wishlists#index"
  delete "wishlists/:id(.:format)", :to => "wishlists#destroy"

  post "/crop_pic", to: "products#crop_pic", as: :crop_pic
  post "/pic_added", to: "products#pic_added", as: :pic_added

  get "/variants/:id", to: "categories#variants", as: :variants

  #errors paths
  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unprocessable"
  get "/500", to: "errors#internal_server"
  get "/204", to: "errors#no_content"

  #subcategories
  get "/subcategories:id", to: "categories#show_sub_category", as: :show_sub_category
  get "/new_subcategory:id", to: "categories#new_sub_category", as: :new_sub_category
  post "/add_subcategory", to: "categories#create_subcategory", as: :create_subcategory
  get "/edit_subcategory:id", to: "categories#edit_sub_category", as: :edit_sub_category
  patch "/update_subcategory", to: "categories#update_subcategory", as: :update_subcategory
  get "/delete_subcategory:id", to: "categories#delete_sub_category", as: :delete_sub_category
  delete "/delete_subcategory", to: "categories#delete_subcategory", as: :delete_subcategory

  get "/years", to: "homes#get_years", as: :get_years

  # notification routes
  get "notifications", to: "admins#notifications_list", as: :notifications
  get "notifications/:id", to: "admins#notification_show", as: :notification_show
  get "media_delete", to: "admins#media_delete", as: :media_delete
end
