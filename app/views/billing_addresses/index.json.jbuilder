json.set! :data do
  json.array! @billing_addresses do |billing_address|
    json.partial! 'billing_addresses/billing_address', billing_address: billing_address
    json.url  "
              #{link_to 'Show', billing_address }
              #{link_to 'Edit', edit_billing_address_path(billing_address)}
              #{link_to 'Destroy', billing_address, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end