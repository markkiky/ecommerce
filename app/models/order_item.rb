class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :product, dependent: :destroy

    def order_total
        price * quantity
    end
end
