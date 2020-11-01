class AddYearToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :year, :string
  end
end
