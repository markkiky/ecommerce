class AddDefaultValueToCategories < ActiveRecord::Migration[6.0]
  def up
    change_column :categories, :active, :boolean, default: true
  end
  
  def down
    change_column :categories, :active, :boolean, default: nil
  end
end
