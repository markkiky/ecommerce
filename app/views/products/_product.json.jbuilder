json.extract! product, :id, :product_id, :sku, :id_sku, :vendor_product_id, :product_name, :product_description, :supplier_id, :category_id, :quantity_per_unit, :price, :unit_price, :msrp, :available_size, :available_colors, :size, :color, :discount, :unit_weight, :units_in_stock, :units_on_order, :reorder_level, :product_available, :discount_available, :current_order, :note, :ranking, :created_at, :updated_at
json.url product_url(product, format: :json)
