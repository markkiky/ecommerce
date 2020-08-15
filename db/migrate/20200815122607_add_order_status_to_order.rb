class AddOrderStatusToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_status, :string, default: 'cart'

    
    Order.where(order_status: nil).update_all(order_status: 'cart')
  end
end
