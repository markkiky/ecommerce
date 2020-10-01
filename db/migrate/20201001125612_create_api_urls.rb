class CreateApiUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :api_urls do |t|
      t.string :key
      t.string :value

      # t.timestamps
    end
  end
end
