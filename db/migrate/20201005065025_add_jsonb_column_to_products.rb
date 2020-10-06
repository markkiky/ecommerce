class AddJsonbColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_group, :jsonb, null: false, default: {}
    add_index :products, :product_group, using: :gin
  end
end
