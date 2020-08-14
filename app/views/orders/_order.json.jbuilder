json.extract! order, :id, :order_id, :customer_id, :order_total, :order_number, :payment_id, :order_date, :ship_date, :required_date, :shipper_date, :freight, :sales_tax, :timestamp, :transact_status, :err_loc, :err_msg, :fulfilled, :deleted, :paid, :payment_date, :created_at, :updated_at
json.url order_url(order, format: :json)
