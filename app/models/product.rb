class Product < ApplicationRecord
    belongs_to :admin
    belongs_to :category
    # belongs_to :size
    # belongs_to :color
    has_many :wishlists
    has_many :reviews
    has_many :product_colors
    has_many :colors, through: :product_colors

    has_many :product_sizes
    has_many :sizes, through: :product_sizes
    
    
    has_many_attached :images
    store_accessor :product_group, :moq, :product_description, :rrp, :whole_sale, :moq_description

    # validate :image_presence
    # has_many_base64_attached :product_images

    def thumbnail input
        return self.images[input].variant(resize: "700x1036!").processed
    end

    private
    def image_presence
        if images.attached? == false
            errors.add(:images, "are missing")
        end
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png'))
                error.add(:images, "needs to be JPEG or PNG")
            end
        end
    end
end
