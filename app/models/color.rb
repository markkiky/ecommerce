class Color < ApplicationRecord
    belongs_to :admin
    # belongs_to :category
    has_many :product_colors
    has_many :products, through: :product_colors
    
end
