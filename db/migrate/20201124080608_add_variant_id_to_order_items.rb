class AddVariantIdToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :variant_id, :string
  end
end
