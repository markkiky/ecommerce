class Product < ApplicationRecord
    belongs_to :admin
    # belongs_to :category
    # belongs_to :size
    # belongs_to :color
    has_many :wishlists
    has_many :reviews
    has_many :product_colors
    has_many :colors, through: :product_colors

    has_many :product_sizes
    has_many :sizes, through: :product_sizes
    
    
    has_many_attached :images
    # has_many_base64_attached :product_images

    def thumbnail input
        return self.images[input].variant(resize: "700x1036!").processed
    end
end
