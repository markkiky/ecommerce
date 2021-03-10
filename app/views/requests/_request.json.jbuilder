json.extract! request, :id, :request_first_name, :request_last_name, :request_phone_number, :request_email, :request_message, :request_subject, :created_at, :updated_at
json.url request_url(request, format: :json)
