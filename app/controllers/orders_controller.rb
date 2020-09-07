class OrdersController < ApplicationController
  require 'resolv-replace' 
  require "uri"
  require "net/http"
  require "json"
 
  before_action :authenticate_admin!, only: [:index, :show]
  before_action :authenticate_customer!, only: [:new, :create]

  def index
    @orders = Order.all
    # @orders.sort_by { |order| [order.order_number, order.order_date] }
    # @orders.sort
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
    @customer.billing_address = params[:customer][:billing_address]
    @customer.billing_country = params[:customer][:billing_country]
    @customer.billing_city = params[:customer][:billing_city]
    @customer.billing_postal_code = params[:customer][:billing_postal_code]
    @customer.delivery_option = params[:customer][:delivery_option]
    @customer.pick_up_option = params[:customer][:pick_up_option]
  
    @customer.save!
    if @order.update_attributes(order_params.merge(order_status: 'pending_payment', order_number: Order.counter, order_date: Date.today()))
      session[:cart_token] = nil
      redirect_to order_payment_path(@order.id)
    else
      render :new
    end 
    # if @order.payment_method == "Mpesa"
      

    # elsif @order.payment_method == "Cash on Delivery"  
    #     redirect_to order_success_path
    #     url = URI("http://sna.co.ke/sna_api/index.php")
    #    http = Net::HTTP.new(url.host, url.port);
    #    request = Net::HTTP::Post.new(url)
    #    form_data = [['function', 'sendMessage'],['phoneNumber', @order.client_phone_number],['message', "Hi #{@order.client_name}. Your Order Number #{@order.id} of KES #{@order.order_subtotal.to_i.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse} is being processed."],['senderId', 'COVERAPP'],['username', 'MALISAFI']]
    #    request.set_form form_data, 'multipart/form-data'
    #    response = http.request(request)
    #    puts response.read_body

    # elsif @order.payment_method == "Card"
    #   redirect_to order_success_path
    # end
     
  end

  def show
  end

  def order_payment
    @order = Order.find(params[:id])
    @customer = Customer.find(@order.customer_id)
    
    # used to return client_side to client for successful payments
    @order_id = @order.id
    
  end

  def order_success
    @order = Order.find(params[:id])
    customer_id = @order.customer_id.to_i
    @customer = Customer.find(customer_id)
  end 
  def destroy
    @order.destroy   
  end
  
  def send_push
    @order = Order.find(params[:id])
    @id = params[:id]
    require "uri"
    require "net/http"

    url = URI("https://payme.revenuesure.co.ke/api/index.php")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    form_data = [['function', 'searchTransactions'],['keyword', @order.order_number],['', '']]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    puts response.read_body

    response_json = JSON.parse(response.read_body)

    if response_json['success'] != true

      # @order.order_number = "shoesX"
      @customer = Customer.find(@order.customer_id)
      url = URI("https://payme.revenuesure.co.ke/index.php")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Post.new(url)
      form_data = [['TransactionType', 'CustomerPayBillOnline'],['PayBillNumber', '367776'],['Amount', @order.order_subtotal.to_i.to_s],['PhoneNumber', @customer.phone],['AccountReference', @order.order_number],['TransactionDesc', @order.order_number],['FullNames', '- - -']]
      request.set_form form_data, 'multipart/form-data'
      response = https.request(request)
      puts response.read_body
      response_json = JSON.parse(response.body)

      # @response = response_json['ResponseDescription']
      @response = "Push Sent"

    else 
      @response = "Already Paid"
      # Save it to db
      if Order.where(:order_number => response_json['data'][0]['TransactionDesc']).exists?
        order = Order.where(:order_number => response_json['data'][0]['TransactionDesc']).last
        callback_params = {
          'transaction_id' => response_json['data'][0]['account_to'], 
          'account_from' => response_json['data'][0]['account_from'], 
          'transaction_code' => response_json['data'][0]['transaction_code'],
          'amount' => response_json['data'][0]['amount'], 
          'order_id' => order.id,
          'message' => response_json['data'][0]['TransactionDesc'],
          'callback_returned' => response_json['data'][0]['names'],
          'date' => response_json['data'][0]['date'],
          'payment_mode' => response_json['data'][0]['payment_mode']
        }
        amount = response_json['data'][0]['amount']
        amount = amount.to_i
      @transaction = Transaction.new(callback_params)
      order.payment_date = Date.today()
      order.transaction_id = @transaction.id
  
      if order.payment_status == "Unpaid"
        balance = order.order_subtotal - amount
        # set the balance here in future.
        order.reducing_balance = balance
      if balance <= 0
        order.payment_status = "Paid"
        order.paid = true
      elsif balance > 0
        order.payment_status = 'part'
      end
      elsif order.payment_status == "part"
        balance = order.reducing_balance - amount
        order.reducing_balance = balance
      if balance <= 0
        order.payment_status = "Paid"
        order.paid = true
      elsif balance > 0
        order.payment_status = 'part'
      end
      
      elsif order.payment_status == "Paid"
      balance = order.reducing_balance - amount
      order.reducing_balance = balance
      end
      # send order received email 
      customer_id = order.customer_id.to_i
      
      @customer = Customer.find(customer_id)
      OrderMailer.with(customer: @customer, transaction: @transaction, order: order).order_payment.deliver_now
      @transaction.save!
      order.save!
    end
    end
    
    

    # redirect_to order_success_path
    # respond_to do |format|
    #   format.js
    # end
  end

  def check_payment
    @order = Order.find(params[:id])

    url = URI("https://payme.revenuesure.co.ke/api/index.php")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    form_data = [['function', 'checkPaymentVerification'],['account_reference', @order.order_number ]]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    puts response.read_body

    response_json = JSON.parse(response.read_body)
    puts response_json['success']
    if response_json['success'] != true
      @response = response_json['message']
    else
      if response_json['data']['callback_returned'] == "PAID"
        
      end
      @response = response_json['data']['callback_returned']
    end
  end
  
  def get_transaction
    
    url = URI("https://payme.revenuesure.co.ke/api/index.php")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    form_data = [['function', 'searchTransactions'],['keyword', 'NGI1CRTJVX'],['', '']]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    puts response.read_body

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:order_id, :customer_id, :order_total, :order_number, :payment_id, :order_subtotal, :order_date, :ship_date, :required_date, :shipper_date, :freight, :sales_tax, :timestamp, :transact_status, :err_loc, :err_msg, :fulfilled, :deleted, :paid, :payment_date, :client_first_name, :client_last_name, :client_phone_number, :client_email, :client_city, :client_address, :client_country, :client_postal_code, :payment_method)
    end
end
