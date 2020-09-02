class Color < ApplicationRecord
    belongs_to :admin
    has_many :product_colors
    has_many :products, through: :product_colors
    
end
