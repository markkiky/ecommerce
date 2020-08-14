class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :customer_id
      t.decimal :order_total
      t.string :order_number
      t.string :payment_id
      t.datetime :order_date
      t.datetime :ship_date
      t.datetime :required_date
      t.datetime :shipper_date
      t.string :freight
      t.string :sales_tax
      t.datetime :timestamp
      t.string :transact_status
      t.string :err_loc
      t.string :err_msg
      t.boolean :fulfilled
      t.boolean :deleted
      t.boolean :paid
      t.datetime :payment_date

      t.timestamps
    end
  end
end
