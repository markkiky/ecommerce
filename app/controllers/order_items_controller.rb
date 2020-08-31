class OrderItemsController < ApplicationController
    def index
        @items = current_cart.order.items
    end

    def create
        current_cart.add_item(
        product_id: params[:product_id],
        quantity: params[:quantity]
        )
    end

    def destroy
        current_cart.remove_item(id: params[:id])
    end
    
end
