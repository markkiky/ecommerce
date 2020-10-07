# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin add
Admin.create!(email: 'markkaris438@gmail.com', password: "123456", owner: true)

# Create roles
Role.create!(title: "NCCGSUPERUSER")

# create sizes
Size.create!(size_type: "green", admin_id: 1)

# create colors
Color.create!(color_type: 'red', admin_id: 1)

# create app inits
ApiUrl.create(:key => "paybill", :value => "175555")
ApiUrl.create(:key => "mpesa_timeout", :value => "45")
ApiUrl.create(:key => "mpesa_retry", :value => "2")
ApiUrl.create(:key => "payme", :value => "https://payme.revenuesure.co.ke/index.php")
ApiUrl.create(:key => "app_name", :value => "Melon Coco")
ApiUrl.create(:key => "app_email", :value => "info@gmail.com")
ApiUrl.create(:key => "app_motto", :value => "Live and Learn")
ApiUrl.create(:key => "app_phone", :value => "0714420943")
ApiUrl.create(:key => "app_location", :value => "Nairobi Kenya")