class AddColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :reducing_balance, :decimal
  end
end
