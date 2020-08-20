class AddSizeIdToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :size_id, :integer
  end
end
