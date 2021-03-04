class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.string :order_id
      t.bigint :status_id, default: 1
      t.string :callback_returned
      t.decimal :amount
      t.string :account_from
      t.string :transaction_code
      t.string :message
      t.datetime :date
      t.string :payment_mode

      t.timestamps
    end
  end
end
