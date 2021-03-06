class ApplicationController < ActionController::Base
  require 'securerandom'
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token

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

  def customer_confirm

    if current_customer == nil

    else
      if current_customer.otp_confirmed == false
        redirect_to customer_edit_password_path
      else

      end

    end

  end

  def admin_confirm

    if current_admin == nil

    else
      if current_admin.otp_confirmed == false
        redirect_to admin_edit_password_path
      else

      end

    end

  end
  
  protected

  def configure_permitted_parameters
    attributes = [:first_name, :last_name, :phone, :billing_address, :billing_postal_code, :billing_country, :billing_city, :shipping_address, :shipping_postal_code, :shipping_country, :shipping_city, :car_name, :car_make, :car_year, :chassis_number, [:avatar]]
    devise_parameter_sanitizer.permit :sign_up, keys: attributes
    devise_parameter_sanitizer.permit :account_update, keys: attributes
  end
end
