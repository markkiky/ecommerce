Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, ENV['4PMy1LPaAW4MeTlM4waws7iPT'], ENV['3NrruiiHohfUggjtpIz3tXVExTkyw6Ygz77nAZ9nfH5wKNUK3s']
end

# bearer token : "AAAAAAAAAAAAAAAAAAAAAF8xGwEAAAAA4N2zHQHdolzZA5HQThTssZh%2BJd8%3D5XzLdaGJMG0XyfXUMKu0fcXLBlYxNE4hTEToRK9OGj3NIEAGTH"

# curl -X GET -H "Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAF8xGwEAAAAA4N2zHQHdolzZA5HQThTssZh%2BJd8%3D5XzLdaGJMG0XyfXUMKu0fcXLBlYxNE4hTEToRK9OGj3NIEAGTH" "https://api.twitter.com/2/tweets/440322224407314432"