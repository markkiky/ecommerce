class Product < ApplicationRecord
    belongs_to :admin
    belongs_to :category
    
    has_many_attached :images
end
