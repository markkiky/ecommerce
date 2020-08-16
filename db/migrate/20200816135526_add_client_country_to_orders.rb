class AddClientCountryToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_country, :string
  end
end
