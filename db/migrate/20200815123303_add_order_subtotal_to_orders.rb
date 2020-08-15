class AddOrderSubtotalToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_subtotal, :decimal
  end
end
