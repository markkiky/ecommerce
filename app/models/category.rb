class Category < ApplicationRecord
    belongs_to :admin
    has_many :products
    store_accessor :variants, :moq, :product_description, :rrp, :whole_sale, :moq_description, :name
    has_many :sub_categories

    has_one_attached :image

    attr_accessor :sub_category_id

    def thumbnail
        return self.image.variant(resize: "1370x385!").processed
    end

end
