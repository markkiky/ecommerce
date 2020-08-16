class AddClientCityToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_city, :string
  end
end
