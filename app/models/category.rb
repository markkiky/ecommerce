class Category < ApplicationRecord
    belongs_to :admin
    has_many :products
end
