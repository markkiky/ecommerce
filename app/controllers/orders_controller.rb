class OrdersController < ApplicationController
  require 'resolv-replace' 
  require "uri"
  require "net/http"
  require "json"
 
  before_action :authenticate_admin!, only: [:index, :show]
  before_action :authenticate_customer!, only: [:new, :create]

  def index
    @orders = Order.all
  end

  def new
    @order = current_cart.order
    @customer = current_customer
  end
 
  def create
    # check if order_cart_subtotal is empty
    #  TO DOs
    @order = current_cart.order
    @order.customer_id = current_customer.id
    
    @customer = current_customer
    @customer.first_name = params[:customer][:first_name]
    @customer.last_name = params[:customer][:last_name]
    # @customer.email = params[:customer][:email]
    @customer.phone = params[:customer][:phone]
    @customer.county = params[:customer][:county]
    @customer.shipping_address = params[:customer][:shipping_address]
    @customer.shipping_city = params[:customer][:shipping_city]
    @customer.shipping_postal_code = params[:customer][:shipping_postal_code]


   @customer.save!
    if @order.update_attributes(order_params.merge(order_status: 'open'))
      session[:cart_token] = nil
    else
      render :new
    end 
    if @order.payment_method == "Mpesa"
      url = URI("https://payme.revenuesure.co.ke/index.php")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      form_data = [['TransactionType', 'CustomerPayBillOnline'],['PayBillNumber', '175555'],['Amount', @order.order_subtotal.to_i.to_s],['PhoneNumber', @customer.phone],['AccountReference', 'PKX2019062'],['TransactionDesc', 'PKX201906264'],['FullNames', '- - -']]
      request.set_form form_data, 'multipart/form-data'
      response = https.request(request)
      puts response.read_body
      redirect_to order_success_path

    elsif @order.payment_method == "Cash on Delivery"  
        redirect_to order_success_path
        url = URI("http://sna.co.ke/sna_api/index.php")
       http = Net::HTTP.new(url.host, url.port);
       request = Net::HTTP::Post.new(url)
       form_data = [['function', 'sendMessage'],['phoneNumber', @order.client_phone_number],['message', "Hi #{@order.client_name}. Your Order Number #{@order.id} of KES #{@order.order_subtotal.to_i.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse} is being processed."],['senderId', 'COVERAPP'],['username', 'MALISAFI']]
       request.set_form form_data, 'multipart/form-data'
       response = http.request(request)
       puts response.read_body

    elsif @order.payment_method == "Card"
      redirect_to order_success_path
    end
     
  end

  def show
  end

  def order_success
    @order = Order.last
  end 
  def destroy
    @order.destroy   
  end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:order_id, :customer_id, :order_total, :order_number, :payment_id, :order_date, :ship_date, :required_date, :shipper_date, :freight, :sales_tax, :timestamp, :transact_status, :err_loc, :err_msg, :fulfilled, :deleted, :paid, :payment_date, :client_first_name, :client_last_name, :client_phone_number, :client_email, :client_city, :client_address, :client_country, :client_postal_code, :payment_method)
    end
end
