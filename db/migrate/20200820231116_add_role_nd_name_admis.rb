class AddRoleNdNameAdmis < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :role_id, :integer
    add_column :admins, :name, :string
  end
end
