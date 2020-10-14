class Category < ApplicationRecord
    belongs_to :admin
    has_many :products
    has_many :sub_categories

    has_one_attached :image
end
