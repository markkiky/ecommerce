json.extract! order_item, :id, :order_id, :product_id, :order_number, :price, :quantity, :discount, :total, :id_sku, :size, :color, :fulfilled, :ship_date, :order_item_id, :bill_date, :created_at, :updated_at
json.url order_item_url(order_item, format: :json)
