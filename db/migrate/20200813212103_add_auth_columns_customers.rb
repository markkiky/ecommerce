class AddAuthColumnsCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :provider, :string
    add_column :customers, :uid, :string
    add_column :customers, :location, :string
    add_column :customers, :image_url, :string
    add_column :customers, :url, :string
    add_index :customers, :provider
    add_index :customers, :uid
    add_index :customers, [:provider, :uid], unique: true
  end
end
