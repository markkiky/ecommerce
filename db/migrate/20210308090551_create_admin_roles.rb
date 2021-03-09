class CreateAdminRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_roles do |t|
      t.bigint :admin_id
      t.bigint :role_id

      t.timestamps
    end
  end
end
