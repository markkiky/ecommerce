class CreateCompleteOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :complete_orders do |t|
      t.string :order_id
      t.string :customer_id
      t.string :order_number
      t.string :payment_id
      t.datetime :order_date
      t.string :required_date
      t.string :shipper_id
      t.string :freight
      t.decimal :sales_tax
      t.string :transaction_status
      t.boolean :paid
      t.datetime :payment_date
      t.boolean :deleted
      t.boolean :fulfilled

      t.timestamps
    end
  end
end
