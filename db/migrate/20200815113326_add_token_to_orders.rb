class AddTokenToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :token, :string
  end
end
