class AddClientFirstNameToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_first_name, :string
  end
end
