class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.string :order_id
      t.string :product_id
      t.string :order_number
      t.decimal :price
      t.integer :quantity
      t.string :discount
      t.decimal :total
      t.string :id_sku
      t.string :size
      t.string :color
      t.boolean :fulfilled
      t.datetime :ship_date
      t.string :order_item_id
      t.datetime :bill_date

      t.timestamps
    end
  end
end
