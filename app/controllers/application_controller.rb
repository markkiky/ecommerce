class ApplicationController < ActionController::Base

  before_action :current_cart

  def current_cart
    @current_cart ||= ShoppingCart.new(token: cart_token)
  end
  helper_method :current_cart
  
  def after_sign_in_path_for(resource)
          if admin_signed_in?
            admin_dashboard_path
          else
            root_path
          end
        end
    
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
