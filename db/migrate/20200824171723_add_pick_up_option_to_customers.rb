class AddPickUpOptionToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :pick_up_option, :string
  end
end
