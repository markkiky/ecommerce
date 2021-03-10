class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.bigint :customer_id
      t.string :address
      t.string :city
      t.string :region
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end
