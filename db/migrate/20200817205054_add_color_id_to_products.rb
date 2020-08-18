class AddColorIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :color_id, :integer
  end
end
