class AddClientPhoneNumberToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_phone_number, :string
  end
end
