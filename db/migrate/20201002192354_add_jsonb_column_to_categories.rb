class AddJsonbColumnToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :variants, :jsonb, null: false, default: {}
    add_index :categories, :variants, using: :gin
  end
end
