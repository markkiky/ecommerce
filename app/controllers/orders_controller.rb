class OrdersController < ApplicationController
  require "business_time"
  require "resolv-replace"
  require "uri"
  require "net/http"
  require "json"
  @@mpesa_timeout = 50
  @@mpesa_retry = 2

  before_action :authenticate_admin!, only: [:index, :show]
  before_action :set_order, only: [:show]

  # after_action :check_payment, only: [:send_push]

  def index
    @orders = Order.where.not(:order_status => "cart")
    # console

  end

  def new
    # console
    @order = current_cart.order
    if current_customer != nil
      @customer = current_customer
    else
      @customer = Customer.new
    end
  end

  # GET /admin_order
  def admin_order
    @order = Order.new
    @categories = Category.all.map { |c| [c.category_name, c.id] }
    respond_to do |format|
      format.html
      format.js
    end
  end

  # get 
  def admin_customer_order
    @products = Product.all
    @customer = Customer.find_by(id: params[:id])
    @order = Order.find_by(id: session["customer_#{params["id"]}"])

  end

  # get 
  # displays modal
  def admin_customer_order_modal
    @product = Product.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # post 
  # submits form modal
  def admin_customer_order_post
    # byebug
    @customer = Customer.find(params[:id])
    if session["customer_#{@customer.id}"] == nil
      @order = Order.create!(
        customer_id: @customer.id,
        order_number: Order.counter,
        order_date: DateTime.now,
        order_subtotal: params[:quantity].to_i * params[:price].to_i
      )
      # byebug
      @order_item = OrderItem.create(
        quantity: params["quantity"],
        price: params["price"],
        product_id: params["product_id"],
        order_id: @order.id
      )
      session["customer_#{@customer.id}"] = @order.id
    else
      @order = Order.find_by(id: session["customer_#{@customer.id}"])
      # byebug
      @order_item = OrderItem.find_or_create_by(order_id: @order.id, product_id: params["product_id"].to_i)
      @order_item.update(
        quantity: params["quantity"],
        price: params["price"],
      )
    end

    respond_to do |format|
      format.js
    end
  end

  def confirm_order
    @customer = Customer.find(params[:id])
    # byebug
    @order = Order.find_by(id: session["customer_#{@customer.id}"])
    
    if @order == nil
      flash[:alert] = "No Order present"
      redirect_to orders_path

    else
      @order.update(
        order_subtotal: @order.items.sum(:price),
        order_status: "pending_payment"
      )
      session.delete("customer_#{@customer.id}")
      # update order
  
  
      flash[:notice] = "Order Confirmed"
      redirect_to orders_path
    end
   
  end

  def admin_customer_cart
    @customer = Customer.find(params[:id])
    @order = Order.find_by(id: session["customer_#{@customer.id}"])
    respond_to do |format|
      format.js
    end
  end

  def choose_payment
    # byebug
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def admin_payment
    @order = Order.find(params[:id])
    if params["payment-group"] == "mpesa"
    elsif params["payment-group"] == "card"
    elsif params["payment-group"] == "cash"
    end
    @payment_group = params["payment-group"]

    respond_to do |format|
      format.js
    end
  end

  # GET /order_product
  def order_product
    @products = Product.where(:category_id => params[:category_id]).map { |p| [p.product_name, p.id] }
    respond_to do |format|
      format.js
    end
  end

  #GET /get_price
  def get_price
    product_id = params[:product_id]
    @product = Product.find(product_id)
    @price = @product.price
    @product_quantity = @product.product_quantity
    respond_to do |format|
      format.js
    end
  end

  def dispatcher
    begin
      @order = Order.find(params[:id])
      @order.update(
        status_id: 7
      )
    rescue => exception

    else
      flash[:notice] = "Order Dispatched"
      redirect_to orders_path
    end
  end

  def delivered
    begin
      @order = Order.find(params[:id])
      @order.update(
        status_id: 8
      )
    rescue => exception

    else
      flash[:notice] = "Order Delivered"
      redirect_to orders_path
    end

  end

  # Submits admin order into orders
  # POST /admin_order
  def create_admin_order
    begin
      puts params
      @order = Order.new(:order_number => Order.counter, :order_date => Time.now, :order_status => "pending_payment", :order_subtotal => (params[:price].to_i * params[:quantity].to_i), :admin_id => current_admin.id)
      @order.save

      OrderItem.create(:order_id => @order.id, :product_id => params[:products], :price => params[:price], :quantity => params[:quantity])
      gon.order = @order
      gon.order_date = @order.order_date.to_s
    rescue => exception
      flash[:alert] = exception
      redirect_to orders_path
    else
      flash[:notice] = "Order Placed Successfully"
      redirect_to orders_path
    end
  end

  def create
    # check if order_cart_subtotal is empty
    #  TO DOs
    
    @order = current_cart.order
    if @order.order_subtotal != 0
      
    
    if current_customer != nil
      @customer = current_customer
      @customer.update_attributes(
        first_name: params[:customer][:first_name],
        last_name: params[:customer][:last_name],
        email: params[:customer][:email],
        phone: params[:customer][:phone]
      )
      if @customer.billing_addresses.count < 1
        @customer.billing_addresses.create(
          address: params[:customer][:billing_address],
          city: params[:customer][:billing_city],
          country: params[:customer][:billing_country],
          postal_code: params[:customer][:billing_postal_code],
        )
      else
        @customer.billing_addresses.first.update_attributes(
          address: params[:customer][:billing_address],
          city: params[:customer][:billing_city],
          country: params[:customer][:billing_country],
          postal_code: params[:customer][:billing_postal_code],
        )
      end
      if @customer.shipping_addresses.count < 1
        @customer.shipping_addresses.create(
          address: params[:customer][:shipping_address],
          city: params[:customer][:shipping_city],
          country: params[:customer][:shipping_country],
          postal_code: params[:customer][:shipping_postal_code],
        )
      else
        @customer.shipping_addresses.first.update_attributes(
          address: params[:customer][:shipping_address],
          city: params[:customer][:shipping_city],
          country: params[:customer][:shipping_country],
          postal_code: params[:customer][:shipping_postal_code],
        )
      end
    elsif current_customer == nil
      # check customer exists
      if Customer.where(:email => params[:customer][:email]).exists?

        @customer = Customer.where(:email => params[:customer][:email]).last
        @customer.update_attributes(
          first_name: params[:customer][:first_name],
          last_name: params[:customer][:last_name],
          email: params[:customer][:email],
          phone: params[:customer][:phone]
        )
        @customer.billing_addresses.create(
          address: params[:customer][:billing_address],
          city: params[:customer][:billing_city],
          country: params[:customer][:billing_country],
          postal_code: params[:customer][:billing_postal_code],
        )
        @customer.shipping_addresses.create(
          address: params[:customer][:shipping_address],
          city: params[:customer][:shipping_city],
          country: params[:customer][:shipping_country],
          postal_code: params[:customer][:shipping_postal_code],
        )
      else
        # Creating New Customer
        password = SecureRandom.hex(6)
        @customer = @order.create_customer(
          first_name: params[:customer][:first_name],
          last_name: params[:customer][:last_name],
          phone: params[:customer][:phone],
          email: params[:customer][:email],
          customer_no: Customer.counter,
          password: password,
          otp: password
        )
        # @customer.cars.create(
        #   car_make: params["car_make"],
        #   car_model: params["car_model"],
        #   car_year: params["car_year"],
        #   chassis_number: params["chassis_number"]
        # )
        @customer.billing_addresses.create(
          address: params[:customer][:billing_address],
          city: params[:customer][:billing_city],
          country: params[:customer][:billing_country],
          postal_code: params[:customer][:billing_postal_code],
        )
        @customer.shipping_addresses.create(
          address: params[:customer][:shipping_address],
          city: params[:customer][:shipping_city],
          country: params[:customer][:shipping_country],
          postal_code: params[:customer][:shipping_postal_code],
        )
        # send welcome email with otp
        CustomerMailer.with(id: @customer.id).welcome_email.deliver_later
      end
    end
    if @order.update_attributes(order_params.merge(order_status: "pending_payment",customer_id: @customer.id, order_number: Order.counter, order_date: Date.today()))
      @order.items.each do |loo|

      end
      session[:cart_token] = nil
      redirect_to order_payment_path(@order.id)
    else
      render :new
    end
  else
    flash[:alert] = "Cart is empty"
      redirect_to products_path
    end
  end

  def show
    puts @order
    # byebug
    @items = @order.items

    respond_to do |format|
      # format.html
      format.js
    end
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

  def order_history
  end

  def destroy
    @order.destroy
  end

  def send_push
    phone = params[:phone]
    @order_id = params[:id]
    @order = Order.find(@order_id)
    @order.phone_number = phone
    begin
      @response = PushSender.call(@order)
      gon.response = @response
    rescue Exception => ex
      puts "#{ex.class}: #{ex.message}"
    end
    respond_to do |format|
      format.js
    end
  end

  # def push_responder
  #   @order = Order.find(params[:id])
  #   respond_to do |format|
  #     format.js
  #   end
  # end

  # GET All MPESA Transactions for a particular paybill with date
  # POST /get_transactions
  def get_transactions
  end

  def card_payment
    @order = Order.find(params[:order_id])
    # puts "REACHED CARD PAYMENTS"
  end

  def search_transactions
    url = URI("https://payme.revenuesure.co.ke/api/index.php")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    form_data = [["function", "searchTransactions"], ["keyword", "NGI1CRTJVX"], ["", ""]]
    request.set_form form_data, "multipart/form-data"
    response = https.request(request)
    puts response.read_body
  end

  def check_payment_old
    # @order = Order.find(params[:id])
    @mpesa_job_id = MpesaWorker.perform_async(params[:id])
    puts "MPESA JOB ID: #{@mpesa_job_id}"
    status = Sidekiq::Status::status(@mpesa_job_id)
    queue = Sidekiq::Status::queued? @mpesa_job_id
    Sidekiq::Status::working? @mpesa_job_id
    Sidekiq::Status::complete? @mpesa_job_id
    Sidekiq::Status::failed? @mpesa_job_id
    puts "Status = #{status}"
    puts "Queued? #{queue}"
    respond_to do |format|
      format.js
    end
    # puts "#{@response} Tumefikiwo"
  end

  def check_payment
    @order = Order.find(params[:id])
    begin
      url = URI("https://payme.revenuesure.co.ke/api/index.php")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      form_data = [["function", "checkPaymentVerification"], ["account_reference", @order.order_number]]
      request.set_form form_data, "multipart/form-data"

      response_json = nil
      begin
        # receipt_response = OpenStruct.new(success: false, response: nil, errors: "No payment Found")
        Timeout.timeout(@@mpesa_timeout) do
          receipt_response = false
          while receipt_response == false
            # receipt_response = BillerManager::BillerReceiptGettor.call(@reference_bill)
            # puts receipt_response
            response = https.request(request)
            # puts response.read_body

            response_json = JSON.parse(response.read_body)
            # byebug
            puts response_json
            if response_json["success"] == false
              count = 0
              while response_json["success"] == false
                count += 1
                response = https.request(request)
                response_json = JSON.parse(response.read_body)
                sleep(@@mpesa_retry)
                if count > AdminConfig[:mpesa_error_detection].to_i
                  receipt_response = true
                  break
                end
              end
            else
              if response_json["data"]["callback_returned"] == "PENDING"
                # check transactions
                sleep(@@mpesa_retry)
              elsif response_json["data"]["callback_returned"] == "PAID"
                after_check_payment(@order.id, response_json)
                if @order.admin_id == nil
                  render :js => "window.location = '#{order_success_path(@order.id)}'"
                else
                  render :js => "window.location = '#{order_success_admin_path(@order.id)}'"
                end
                receipt_response = true
              elsif response_json["data"]["callback_returned"] == "UNPAID"
                receipt_response = true
              end
            end
          end
          raise Timeout::Error
        end
      rescue Timeout::Error
        puts "Timed out now: "
        if response_json["success"]
          gon.response_json = response_json
          gon.status = response_json["data"]["callback_returned"].downcase
          gon.order_id = params[:id]
        else
          # check transactions. If still not paid
          gon.response_json = "Failed to send push request"
          gon.status = "404"
          gon.order_id = params[:id]
        end
        # order_controller = OrdersController.new
        after_check_payment(@order.id, response_json)
      end
    rescue Exception => ex
      puts "#{ex.class}: #{ex.message}"
      gon.response_json = ex.message
      gon.status = "failed"
      gon.order_id = params[:id]
    end

    respond_to do |format|
      format.js
    end
  end
  #
  def after_check_payment(order_id, response_json)
    # Things to return declaration
    @response_json = response_json
    @order = Order.find(order_id)
    @status = nil
    # split up objects for easier saving
    if response_json["success"] == true
      transaction_data = response_json["data"]
      if transaction_data["callback_returned"] == "PENDING"
        puts "PENDING"
        # ActionCable.server.broadcast "test_channel", message: "Failed To Get Payment"
        # ActionCable.server.broadcast "test_channel", response_json: response_json, status: "pending", order_id: order_id
      elsif transaction_data["callback_returned"] == "PAID"
        puts "PAID"
        # Saving Payment
        payment_data = response_json["data"]
        # Create a new transaction for the received data
        # check if order exists
        # if order = Order.where(:order_number => payment_data["ref"])

        transaction_params = {
          "paybill_number" => payment_data["account_to"],
          "phone_number" => payment_data["account_from"],
          "transaction_code" => payment_data["transaction_code"],
          "amount" => payment_data["amount"],
          "order_id" => order_id,
          "account_reference" => payment_data["ref"],
          "transaction_description" => payment_data["TransactionDesc"],
          "full_names" => payment_data["names"],
          "date" => payment_data["date"],
          "payment_mode" => payment_data["payment_mode"],
        }
        @transaction = Transaction.new(transaction_params)
        @transaction.save!

        @order.update(:payment_status => "paid", :reducing_balance => 0, :payment_method => "MPESA", :order_status => "payment_received", :payment_date => @transaction.date, :paid => true)
        # save_payment(order_id, response_json)
        RemoveStockJob.perform_later(@order.id)

        # ActionCable.server.broadcast "test_channel", message: "Payment Received"
        # TestChannel.broadcast_to(current_customer, message: "Payment Received", status: "paid")
        # ActionCable.server.broadcast "test_channel", response_json: response_json, status: "paid", order_id: order_id
      elsif response_json["data"]["callback_returned"] == "UNPAID"
        puts "UNPAID"
        # ActionCable.server.broadcast "test_channel", message: response_json["data"]["callback_returned"]
        # TestChannel.broadcast_to(current_customer, message: response_json["data"]["callback_returned"], status: "UNPAID")
        # ActionCable.server.broadcast "test_channel", response_json: response_json, status: "unpaid", order_id: order_id
      else
        puts "FAILED"
        ActionCable.server.broadcast "test_channel", response_json: response_json, status: "error", order_id: order_id
      end
    elsif response_json["success"] == false
      ActionCable.server.broadcast "test_channel", message: "Failed to send push"
    end
  end

  def save_payment(order_id, response_json)
    if Order.where(:order_number => params[:AccountReference]).exists?
      order = Order.where(:order_number => params[:AccountReference]).last
      @transaction.order_id = order.id
      @transaction.save!

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
          order.payment_status = "part"
        end
      elsif order.payment_status == "part"
        balance = order.reducing_balance - amount
        order.reducing_balance = balance
        if balance <= 0
          order.payment_status = "Paid"
          order.paid = true
        elsif balance > 0
          order.payment_status = "part"
        end
      elsif order.payment_status == "Paid"
        balance = order.reducing_balance - amount
        order.reducing_balance = balance
      end

      # send order received email
      customer_id = order.customer_id.to_i
      @customer = Customer.find(customer_id)
      # send email notification
      OrderMailer.with(customer: @customer, transaction: @transaction, order: order).order_payment.deliver_now
      # broadcast to mpesa channel
      # ActionCable.server.broadcast "mpesa_channel_#{order.id}", phone: params[:PhoneNumber], transaction_code: params[:MpesaReceiptNumber], paybill: params[:PayBillNumber]
    else
    end
  end

  # saves payments
  def after_check_payment_old(order_id, response_json)
    puts "BACK TO THE CONTROLLER YAAAAY!!!!!!!!"

    # split up objects for easier saving
    if response_json["success"] == true
      transaction_data = response_json["data"]
      if transaction_data["callback_returned"] == "PENDING"
        puts "PENDING"
        # ActionCable.server.broadcast "test_channel", message: "Failed To Get Payment"
        ActionCable.server.broadcast "test_channel", response_json: response_json, status: "pending", order_id: order_id
      elsif transaction_data["callback_returned"] == "PAID"
        puts "PAID"
        # Saving Payment
        payment_data = response_json["data2"]
        # Create a new transaction for the received data
        # check if order exists
        # if order = Order.where(:order_number => payment_data["ref"])
        if order = Order.find(order_id)
          order_id = order.id
        else
          # place in order number
          order_id = 1
        end
        transaction_params = {
          "paybill_number" => payment_data["account_to"],
          "phone_number" => payment_data["account_from"],
          "transaction_code" => payment_data["transaction_code"],
          "amount" => payment_data["amount"],
          "order_id" => order_id,
          "account_reference" => payment_data["ref"],
          "transaction_description" => payment_data["TransactionDesc"],
          "full_names" => payment_data["names"],
          "date" => payment_data["date"],
          "payment_mode" => payment_data["payment_mode"],
        }
        @transaction = Transaction.new(transaction_params)
        @transaction.save
        # ActionCable.server.broadcast "test_channel", message: "Payment Received"
        # TestChannel.broadcast_to(current_customer, message: "Payment Received", status: "paid")
        ActionCable.server.broadcast "test_channel", response_json: response_json, status: "paid", order_id: order_id
      elsif response_json["data"]["callback_returned"] == "UNPAID"
        puts "UNPAID"
        # ActionCable.server.broadcast "test_channel", message: response_json["data"]["callback_returned"]
        # TestChannel.broadcast_to(current_customer, message: response_json["data"]["callback_returned"], status: "UNPAID")
        ActionCable.server.broadcast "test_channel", response_json: response_json, status: "unpaid", order_id: order_id
      else
        puts "FAILED"
        ActionCable.server.broadcast "test_channel", response_json: response_json, status: "error", order_id: order_id
      end
    elsif response_json["success"] == false
      ActionCable.server.broadcast "test_channel", message: "Failed to send push"
    end
  end

  def fetch
    job_id = params[:job_id]
    if Sidekiq::Status::complete? job_id
      render :status => 200, :text => Sidekiq::Status::get(job_id, :output)
    elsif Sidekiq::Status::failed? job_id
      render :status => 500, :text => "Failed"
    else
      render :status => 202, :text => ""
    end

    respond_to do |format|
      format.js
    end
  end

  def get_transaction
    url = URI("https://payme.revenuesure.co.ke/api/index.php")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    form_data = [["function", "searchTransactions"], ["keyword", "NGI1CRTJVX"], ["", ""]]
    request.set_form form_data, "multipart/form-data"
    response = https.request(request)
    puts response.read_body
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # define a set of transaction params

  def transaction_params
    params.require(:transaction).permit()
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:order_id, :customer_id, :order_total, :order_number, :payment_id, :order_subtotal, :order_date, :ship_date, :required_date, :shipper_date, :freight, :sales_tax, :timestamp, :transact_status, :err_loc, :err_msg, :fulfilled, :deleted, :paid, :payment_date, :client_first_name, :client_last_name, :client_phone_number, :client_email, :client_city, :client_address, :client_country, :client_postal_code, :payment_method)
  end
end
