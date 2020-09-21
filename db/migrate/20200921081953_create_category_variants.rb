class CreateCategoryVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :category_variants do |t|
      t.string :variant_name
      t.string :variant_value
      t.string :variant_code
      t.string :category_id
      
      t.timestamps
    end
  end
end
