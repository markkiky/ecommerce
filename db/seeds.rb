# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin add
# Admin.create!(email: 'markkaris438@gmail.com', password: "123456", owner: true)

# Create roles
Role.create!(title: "Super Admin")
Role.create!(title: "Admin")
Admin.create(email: "mark@nouveta.tech", password: "123456", role_id: "1")
Admin.create(email: "markkaris438@gmail.com", password: "123456", role_id: "2")

# create sizes
# Size.create!(size_type: "green", admin_id: 1)

# create colors
# Color.create!(color_type: 'red', admin_id: 1)

# create app inits
ApiUrl.create(:key => "paybill", :value => "175555")
ApiUrl.create(:key => "mpesa_timeout", :value => "45")
ApiUrl.create(:key => "mpesa_retry", :value => "2")
ApiUrl.create(:key => "payme", :value => "https://payme.revenuesure.co.ke/index.php")
ApiUrl.create(:key => "app_name", :value => "UAE Auto Spares")
ApiUrl.create(:key => "app_email", :value => "uaeautospares@gmail.com")
ApiUrl.create(:key => "app_motto", :value => "Home of Automotive Spare Parts")
ApiUrl.create(:key => "app_phone", :value => "+254721954217")
ApiUrl.create(:key => "app_phone_2", :value => "+254721374956, +254748322876, +971559384532, +971553705590")
ApiUrl.create(:key => "app_location", :value => "Foremost Auto Center Garden Estate - Thika Road")
ApiUrl.create(:key => "app_facebook", :value => "https://www.facebook.com/Uaeautospares-644917185981216/")
ApiUrl.create(:key => "app_twitter", :value => "https://twitter.com/uaeautospares")
ApiUrl.create(:key => "app_instagram", :value => "https://www.instagram.com/uaeautospares")
ApiUrl.create(:key => "default_url_options", :value => "localhost:3000")
ApiUrl.create(:key => "mpesa_error_detection", :value => "6")
ApiUrl.create(:key => "shop_number", :value => "2")
ApiUrl.create(:key => "whatsapp_contact", :value => "0721954217")
