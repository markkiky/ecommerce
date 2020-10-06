class OrderItemsController < ApplicationController
    def index
        @items = current_cart.order.items
    end

    def create
        # calculate price depending on moq
        moq = params['current_moq'].to_i
        rrp_price = params['rrp_price'].to_i
        whole_sale_price = params["whole_sale_price"].to_i
        quantity = params["quantity"].to_i
        price = nil

        if quantity > moq
            # use wholesale 
            price = whole_sale_price 
        elsif quantity < moq
            # USE RRP
            price = rrp_price 
        elsif quantity == moq
            # USE WHOLESALE
            price = whole_sale_price 
        end

        current_cart.add_item(
        product_id: params[:product_id],
        quantity: params[:quantity].to_i,
        price: price
        )
    end

    def destroy
        current_cart.remove_item(id: params[:id])
    end
    
end
