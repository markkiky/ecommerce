json.extract! transaction, :id, :transaction_id, :order_id, :callback_returned, :amount, :account_from, :transaction_code, :message, :date, :payment_mode, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
