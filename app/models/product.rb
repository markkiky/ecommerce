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
    store_accessor :product_group, :moq, :product_description, :rrp, :whole_sale, :moq_description
end
