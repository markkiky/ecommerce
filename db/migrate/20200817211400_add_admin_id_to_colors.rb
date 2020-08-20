class AddAdminIdToColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :admin_id, :integer
  end
end
