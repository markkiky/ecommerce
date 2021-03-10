json.set! :data do
  json.array! @shipping_addresses do |shipping_address|
    json.partial! 'shipping_addresses/shipping_address', shipping_address: shipping_address
    json.url  "
              #{link_to 'Show', shipping_address }
              #{link_to 'Edit', edit_shipping_address_path(shipping_address)}
              #{link_to 'Destroy', shipping_address, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end