class Size < ApplicationRecord
    belongs_to :admin
    has_many :products
end
