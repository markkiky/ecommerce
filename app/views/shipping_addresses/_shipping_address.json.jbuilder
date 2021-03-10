json.extract! shipping_address, :id, :address, :city, :region, :postal_code, :country, :created_at, :updated_at
json.url shipping_address_url(shipping_address, format: :json)
