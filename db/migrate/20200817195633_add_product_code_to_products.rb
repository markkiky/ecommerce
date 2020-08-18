class AddProductCodeToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_code, :string
  end
end
