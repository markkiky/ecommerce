class AddClientEmailToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_email, :string
  end
end
