json.extract! transaction, :id, :transaction_id, :order_id, :full_names, :amount, :phone_number, :transaction_code, :message, :date, :payment_mode, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
