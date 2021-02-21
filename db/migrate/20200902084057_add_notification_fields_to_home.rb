class AddNotificationFieldsToHome < ActiveRecord::Migration[6.0]
  def change
    add_column :homes, :notification_first_name, :string
    add_column :homes, :notification_last_name, :string
    add_column :homes, :notification_phone_number, :string
    add_column :homes, :notification_subject, :string
    add_column :homes, :notification_email, :string
    add_column :homes, :notification_message, :text
    add_column :homes, :notification_read, :boolean, default: false
  end
end
