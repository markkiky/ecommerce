class AdminsController < ApplicationController
  before_action :authenticate_admin!
  console

  def dashboard
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

  #   Show a particular Customer
  #   GET /customers/list/:id
  def show_customer
    @customers = Customer.all
  end

  def add_customer
  end

  # POST /customers/create
  def create_customer
    begin
      @customer = Customer.create!(first_name: params["first_name"], last_name: params["last_name"], phone: params["phone"], email: params["email"], password: params["password"])
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
      @admin = Admin.create!(first_name: params["first_name"], last_name: params["last_name"], phone: params["phone"], email: params["email"], password: params["password"], role_id: params["role_id"])
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
end
