class AddCarMakeToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :car_make, :string
  end
end
