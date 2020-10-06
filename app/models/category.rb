class Category < ApplicationRecord
    belongs_to :admin
    has_many :products
    store_accessor :variants, :moq, :product_description, :rrp, :whole_sale, :moq_description, :name
end
