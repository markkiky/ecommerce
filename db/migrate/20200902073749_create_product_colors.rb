class CreateProductColors < ActiveRecord::Migration[6.0]
  def change
    create_table :product_colors, id: false do |t|
      t.references :product, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true

      # t.timestamps
    end
  end
end
