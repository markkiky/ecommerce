




Rails.application.config.middleware.use OmniAuth::Builder do
    # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    provider :twitter,  ENV['TWITTER_KEY'],ENV['TWITTER_SECRET'],
    {
      :secure_image_url => 'true',
      :image_size => 'original',
      :authorize_params => {
        :force_login => 'true',
        :lang => 'pt'
      }
    }
    provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"],ENV["GOOGLE_CLIENT_SECRET"], skip_jwt: true
    provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], skip_jwt: true
    # provider :admin, ENV["CLIENT_ID"],ENV["CLIENT_SECRET"], skip_jwt: true
end

# bearer token : "AAAAAAAAAAAAAAAAAAAAAF8xGwEAAAAA4N2zHQHdolzZA5HQThTssZh%2BJd8%3D5XzLdaGJMG0XyfXUMKu0fcXLBlYxNE4hTEToRK9OGj3NIEAGTH"

# curl -X GET -H "Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAF8xGwEAAAAA4N2zHQHdolzZA5HQThTssZh%2BJd8%3D5XzLdaGJMG0XyfXUMKu0fcXLBlYxNE4hTEToRK9OGj3NIEAGTH" "https://api.twitter.com/2/tweets/440322224407314432"