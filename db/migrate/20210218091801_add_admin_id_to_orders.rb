class AddAdminIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :admin_id, :integer
  end
end
