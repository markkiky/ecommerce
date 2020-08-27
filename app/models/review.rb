class Review < ApplicationRecord
    belongs_to :product 
    belongs_to :customer
end
