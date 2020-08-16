class AddClientAddressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_address, :string
  end
end
