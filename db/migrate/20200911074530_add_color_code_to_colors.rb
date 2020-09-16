class AddColorCodeToColors < ActiveRecord::Migration[6.0]
  def change
    add_column :colors, :color_code, :string
  end
end
