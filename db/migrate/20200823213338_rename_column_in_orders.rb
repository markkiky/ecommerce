class RenameColumnInOrders < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :payment_id, :transaction_id
    remove_column :orders, :client_first_name
    remove_column :orders, :client_last_name
    remove_column :orders, :client_email
    remove_column :orders, :client_phone_number
    remove_column :orders, :client_country
    remove_column :orders, :client_address
    remove_column :orders, :client_city
    remove_column :orders, :client_postal_code
    
  end
end
