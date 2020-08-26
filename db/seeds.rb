# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin add
Admin.create!(email: 'markkaris438@gmail.com', encrypted_password: "", owner: true)

# Create roles
Role.create!(title: "NCCGSUPERUSER")

# create sizes
Size.create!(size_type: "green", admin_id: 1)

# create colors
Color.create!(color_type: 'red', admin_id: 1)