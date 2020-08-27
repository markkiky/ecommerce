class AddCustomerIdToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :customer_id, :integer
  end
end
