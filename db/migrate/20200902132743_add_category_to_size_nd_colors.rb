class AddCategoryToSizeNdColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :category_id, :string
    add_column :sizes, :category_id, :string
  end
end
