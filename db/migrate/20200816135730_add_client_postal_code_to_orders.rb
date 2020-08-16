class AddClientPostalCodeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_postal_code, :string
  end
end
