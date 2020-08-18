class Product < ApplicationRecord
    belongs_to :admin
    belongs_to :category
    belongs_to :size
    belongs_to :color
    
    has_many_attached :images
end
