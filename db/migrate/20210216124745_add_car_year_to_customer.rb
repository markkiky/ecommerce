class AddCarYearToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :car_year, :string
  end
end
