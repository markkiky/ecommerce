class RenameAndAddColumnsInTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :paybill_number, :string
    add_column :transactions, :account_reference, :string
    add_column :transactions, :transaction_description, :string
    rename_column :transactions, :callback_returned, :full_names
    rename_column :transactions, :account_from, :phone_number
  end
end
