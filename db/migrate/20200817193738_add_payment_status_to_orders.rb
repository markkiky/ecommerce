class AddPaymentStatusToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_status, :string, default: "Unpaid"
  end
end
