class AddDeliveryOptionToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :delivery_option, :string
  end
end
