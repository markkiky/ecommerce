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
Role.create!(title: "NCCGSUPERUSER")

# create sizes
# Size.create!(size_type: "green", admin_id: 1)

# # create colors
# Color.create!(color_type: 'red', admin_id: 1)

# create app inits
ApiUrl.create(:key => "paybill", :value => "175555")
ApiUrl.create(:key => "mpesa_timeout", :value => "45")
ApiUrl.create(:key => "mpesa_retry", :value => "2")
ApiUrl.create(:key => "payme", :value => "https://payme.revenuesure.co.ke/index.php")
ApiUrl.create(:key => "app_name", :value => "UAE Auto Spares")
ApiUrl.create(:key => "app_email", :value => "uaeautospares@gmail.com")
ApiUrl.create(:key => "app_motto", :value => "Home of Automotive Spare Parts")
ApiUrl.create(:key => "app_phone", :value => "+ 254 721 954 217")
ApiUrl.create(:key => "app_phone_2", :value => "+ 254 769 308 221 +971 55 938 4532 +971 55 370 5590 +254 748 322 876")
ApiUrl.create(:key => "app_location", :value => "Foremost Auto Centre" + "\n" + "Nairobi Kenya")
ApiUrl.create(:key => "app_facebook", :value => "https://www.facebook.com/UAE-Auto-Spares-113557460514133/")
ApiUrl.create(:key => "app_twitter", :value => "https://twitter.com/uaeautospares")
ApiUrl.create(:key => "app_instagram", :value => "https://www.instagram.com/uaeautospares/")
ApiUrl.create(:key => "default_url_options", :value => "localhost:3000")
ApiUrl.create(:key => "mpesa_error_detection", :value => "6")
ApiUrl.create(:key => "shop_number", :value => "1")
ApiUrl.create(:key => 'whatsapp_contact', :value => '0714420943')
ApiUrl.create(:key => 'admin_footer', :value => "This is arigiene shop")
