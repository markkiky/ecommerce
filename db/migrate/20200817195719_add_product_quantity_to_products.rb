class AddProductQuantityToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_quantity, :integer
  end
end
