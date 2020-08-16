class AddAdminIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :admin_id, :integer
  end
end
