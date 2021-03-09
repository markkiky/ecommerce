class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.bigint :customer_id
      t.string :car_make
      t.string :car_model
      t.string :car_year
      t.string :chassis_number

      t.timestamps
    end
  end
end
