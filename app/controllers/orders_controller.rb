class OrdersController < ApplicationController
  require "resolv-replace"
  require "uri"
  require "net/http"
  require "json"
  @@mpesa_timeout = 30
  @@mpesa_retry = 3

  before_action :authenticate_admin!, only: [:index, :show]
  before_action :authenticate_customer!, only: [:new, :create]

  # before_action :set_order, only: [:check_payment]

  # after_action :check_payment, only: [:send_push]

  def index
    @orders = Order.where.not(:order_status => "cart")
    # @orders.sort_by { |order| [order.order_number, order.order_date] }
    # @orders.sort
  end

  def new
    @order = current_cart.order
    @customer = current_customer
  end

  # GET /admin_order
  def admin_order
    @order = Order.new
    @categories = Category.all.map { |c| [c.category_name, c.id] }
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
    respond_to do |format|
      format.js
    end
  end

  # Submits admin order into orders
  # POST /admin_order
  def create_admin_order
    puts params
    @order = Order.new(:order_number => Order.counter, :order_date => Time.now, :order_status => "pending_payment")

    @order.save

    @order_id = @order.order_id
    @order_date = @order.order_date
    @order_total = @order.order_subtotal
    @payment_method = @order.payment_method
    @order_status = @order.order_status
    respond_to do |format|
      format.js
    end
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
    if @order.update_attributes(order_params.merge(order_status: "pending_payment", order_number: Order.counter, order_date: Date.today()))
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
    phone = params[:phone]
    order_id = params[:id]
    @order = Order.find(order_id)
    @order_id = @order.id
    begin
      url = URI("https://payme.revenuesure.co.ke/index.php")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      form_data = [["function", "CustomerPayBillOnlinePush"], ["PayBillNumber", "367776"], ["Amount", @order.order_subtotal.to_s], ["PhoneNumber", phone], ["AccountReference", @order.order_number], ["TransactionDesc", @order.order_number], ["FullNames", "- - -"]]
      request.set_form form_data, "multipart/form-data"
      response = https.request(request)
      puts response.read_body
      response_json = JSON.parse(response.read_body)
      if response_json["success"]
        # push sent

      else
        # push not sent
      end
    rescue Exception => ex
      puts "#{ex.class}: #{ex.message}"
    end
    render :file => "orders/send_push.js.erb"

    # check_payment(order_id)
  end

  # GET All MPESA Transactions for a particular paybill with date
  # POST /get_transactions
  def get_transactions
  end

  def card_payment 
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
              sleep(@@mpesa_retry)
            else
              if response_json["data"]["callback_returned"] == "PENDING"
                sleep(@@mpesa_retry)
              elsif response_json["data"]["callback_returned"] == "PAID"
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

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.js
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
        # ActionCable.server.broadcast "test_channel", response_json: response_json, status: "unpaid", order_id: order_id
      else
        puts "FAILED"
        ActionCable.server.broadcast "test_channel", response_json: response_json, status: "error", order_id: order_id
      end
    elsif response_json["success"] == false
      ActionCable.server.broadcast "test_channel", message: "Failed to send push"
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
