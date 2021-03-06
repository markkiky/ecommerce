source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

#gem passenger
# gem "passenger", ">= 6.0.6", require: "phusion_passenger/rack_handler"

gem 'business_time'

#jquery
gem 'jquery-rails'
gem 'cropper-rails'

# bootstrap
gem 'bootstrap', '~> 4.0'
gem 'jquery-datatables'

gem 'gon', '~> 6.4'

#simple form for 
gem 'simple_form'

#tawk.to authentication
gem 'tawk_rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'

# Use Mysql2 as the database for Active Record
gem 'mysql2'

# Use Puma as the app server
gem 'puma', '~> 4.1'

# Devise gems 
gem 'devise'
gem 'omniauth'
# Use Omniauth Google plugin
gem 'omniauth-google-oauth2'
# Use Omniauth Facebook plugin
gem 'omniauth-facebook'
# Use Omniauth Twitter plugin
gem 'omniauth-twitter'
# Use ActiveRecord Sessions
# gem 'activerecord-session_store', '~> 1.0'

gem 'figaro'

gem 'sprockets-rails', :require => 'sprockets/railtie'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

gem 'sidekiq'
gem 'sidekiq-status'
gem 'sinatra', require: false
gem 'slim'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'active_storage_base64'
gem "mini_magick"

gem 'jquery-fileupload-rails', '~> 0.4.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'dotenv-rails'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails_db'
  gem 'solargraph'
  gem 'htmlbeautifier'
  #real favicon gem
   gem 'rails_real_favicon'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :production do 
  # Compile javascripts and css in production
  gem 'mini_racer'
  gem 'uglifier', '~> 4.2'
  gem 'yui-compressor', '~> 0.12.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
