class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require "resolv-replace"
  before_action :current_cart

  def current_cart
    @current_cart ||= ShoppingCart.new(token: cart_token)
  end
  helper_method :current_cart

  
  def wishlist_text
    return @wishlist_exists ? "Remove from Wishlist" : "Add to Wishlist"
  end    
 helper_method :wishlist_text
  
  private

    def current_user
        @current_user ||= Customer.find_by(id: session[:user_id])
    end
    helper_method :current_user

  #generate cart token  
  def cart_token
    return @cart_token unless @cart_token.nil?

    session[:cart_token] ||= SecureRandom.hex(8)
    @cart_token = session[:cart_token]
  end

end
