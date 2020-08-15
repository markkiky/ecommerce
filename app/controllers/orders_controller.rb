class OrdersController < ApplicationController
 
  before_action :authenticate_admin!, only: [:index, :show]

  def index
    @orders = Order.all
  end

  def new
    @order = current_cart.order
  end
 
  def create
   @order = current_cart.order
    if @order.update_attributes(order_params.merge(order_status: 'open'))
      session[:cart_token] = nil
      redirect_to root_path
    else
      render :new
    end 
     
  end

  def show
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
      params.require(:order).permit(:order_id, :customer_id, :order_total, :order_number, :payment_id, :order_date, :ship_date, :required_date, :shipper_date, :freight, :sales_tax, :timestamp, :transact_status, :err_loc, :err_msg, :fulfilled, :deleted, :paid, :payment_date)
    end
end
