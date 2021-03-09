class AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :admin_confirm

  def dashboard
    # console
    @overall_earnings = Transaction.sum(:amount)
    @mpesa_earnings = Transaction.where(:payment_mode => "MPESA").sum(:amount)
    @card_earnings = Transaction.where(:payment_mode => "CARD").sum(:amount)
    @total_earnings = Transaction.sum(:amount)
    # Order.where('extract(month from created_at)=?', 4)
  end

  def index
    @admins = Admin.all
  end

  #   Show a particular Admin
  #   GET /admins/list/:id
  def show
    @admin = Admin.find(params[:id])
  end

  def show_admin_orders
    @admin = Admin.find(params[:id])
  end

  #   Show a particular Customer
  #   GET /customers/list/:id
  def show_customer
    @customer = Customer.find(params[:id])
  end

  def show_customer_orders
    @customer = Customer.find(params[:id])
  end

  def add_customer
  end

  def edit_password
    @admin = current_admin
  end

  # POST 
  def update_password
    begin
      if params["password"] == params["password_confirmation"]
        current_admin.update(
          password: params["password"],
          otp_confirmed: true
        )
        # sign_in current_customer  
      else
        raise "Password Confirmation error"
      end
      
    rescue => exception
      flash[:alert] = "Failed to change Password"
      redirect_to admin_edit_password_path
    else
      flash[:success] = "Password Changed successfully"
      redirect_to new_admin_session_path
    end
  end

  # POST /customers/create
  def create_customer
    begin
      password = SecureRandom.hex(5)
      @customer = Customer.create!(first_name: params["first_name"], last_name: params["last_name"], phone: params["phone"], email: params["email"], password: password, customer_no: Customer.counter, otp: password)
      # create customer car 
      @customer.cars.build(
        car_make: params["car_make"],
        car_model: params["car_model"],
        car_year: params["car_year"],
        chassis_number: params["chassis_number"]
      )
      @customer.save!

      CustomerMailer.with(id: @customer.id).welcome_email.deliver_later
    rescue => exception
      flash[:alert] = exception
      redirect_to add_customer_path
    else
      flash[:notice] = "Customer created Successfully"
      redirect_to customers_path
    end
  end

  def add_admin
    @roles = Role.all
  end

  def create_admin
    begin
      password = SecureRandom.hex(5)
      @admin = Admin.create!(first_name: params["first_name"], last_name: params["last_name"], phone: params["phone"], email: params["email"], password: password, otp: password)
      params["role_ids"].each do |role_id|
        @admin_role = AdminRole.make(@admin.id, role_id)
      end
      AdminMailer.with(id: @admin.id).welcome_email.deliver_later
    rescue => exception
      flash[:alert] = exception
      redirect_to add_admin_path
    else
      flash[:notice] = "Admin created Successfully"
      redirect_to admins_list_path
    end
  end

  def admin_order_history
  end

  def order_success_admin
    @order = Order.find(params[:id])
  end

  def notifications_list
    @notifications = Home.all
  end

  def notification_show
    @home = Home.find(params[:id])
    @home.update(
      notification_read: true,
    )
    puts @home.notification_email
    @media = @home.images
    # byebug
    # console
  end

  def media_delete
    begin
      # byebug
      @media = ActiveStorage::Attachment.find(params[:media])
      @media.purge
    rescue => exception
      flash[:alert] = exception
      redirect_to notification_show_path(id: params[:id])
    else
      flash[:notice] = "Media deleted Successfully"
      redirect_to notification_show_path(id: params[:id])
    end
  end
end
