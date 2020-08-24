class AddShippingOptionToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :shipping_option, :string 
  end
end
