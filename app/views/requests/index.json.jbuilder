json.set! :data do
  json.array! @requests do |request|
    json.partial! 'requests/request', request: request
    json.url  "
              #{link_to 'Show', request }
              #{link_to 'Edit', edit_request_path(request)}
              #{link_to 'Destroy', request, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end