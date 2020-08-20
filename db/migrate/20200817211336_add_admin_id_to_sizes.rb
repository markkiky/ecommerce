class AddAdminIdToSizes < ActiveRecord::Migration[6.0]
  def change
    add_column :sizes, :admin_id, :integer
  end
end
