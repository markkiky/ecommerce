class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.string :first_name
      t.string :last_name
      t.string :class
      t.string :room
      t.string :building
      t.string :address1
      t.string :address2
      t.string :city
      t.string :county
      t.string :phone
      t.string :email
      t.string :password
      t.string :credit_card
      t.integer :credit_card_type_id
      t.integer :card_exp_mo
      t.integer :card_exp_yr
      t.string :billing_address
      t.string :billing_city
      t.string :billing_region
      t.string :billing_postal_code
      t.string :billing_country
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_region
      t.string :shipping_postal_code
      t.string :shipping_country
      t.string :car_name
      t.string :car_make
      t.string :car_year
      t.string :chassis_number

      t.timestamps
    end
  end
end
