class AddCardParamsToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :status, :string
    add_column :transactions, :reconciliation_id, :string
    add_column :transactions, :currency, :string
  end
end
