class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :product

    def order_total
        price * quantity
    end
end
