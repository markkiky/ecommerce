# Intialise data
Admin.create!(email: 'markkaris438@gmail.com', password: "123456", owner: true)

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
ApiUrl.create(:key => 'payme', :value => "https://payme.revenuesure.co.ke/index.php")