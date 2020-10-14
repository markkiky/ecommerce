class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :category_id
      t.string :sub_category_id
      t.string :sku
      t.string :id_sku
      t.string :vendor_product_id
      t.string :product_name
      t.text :product_description
      t.string :supplier_id
      t.string :quantity_per_unit
      t.decimal :price
      t.decimal :unit_price
      t.string :msrp
      t.string :available_size
      t.string :available_colors
      t.string :size
      t.string :color
      t.string :discount
      t.string :unit_weight
      t.string :units_in_stock
      t.string :units_on_order
      t.string :reorder_level
      t.string :product_available
      t.string :discount_available
      t.string :current_order
      t.string :note
      t.string :ranking

      t.timestamps
    end
  end
end
