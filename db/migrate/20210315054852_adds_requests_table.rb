class AddsRequestsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string "request_first_name"
      t.string "request_last_name"
      t.string "request_phone_number"
      t.string "request_email"
      t.string "request_message"
      t.string "request_subject"
      t.boolean "request_read", default: false
      t.timestamps
    end
  end
end
