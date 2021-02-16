class AddChassisNumberToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :chassis_number, :string
  end
end
