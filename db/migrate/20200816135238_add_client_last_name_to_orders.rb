class AddClientLastNameToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_last_name, :string
  end
end
