class AddCarNameToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :car_name, :string
  end
end
