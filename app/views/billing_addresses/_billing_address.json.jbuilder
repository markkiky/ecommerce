json.extract! billing_address, :id, :address, :city, :region, :postal_code, :country, :created_at, :updated_at
json.url billing_address_url(billing_address, format: :json)
