class Home < ApplicationRecord
  attr_accessor :category_id, :subcategory_id, :year
  has_many_attached :images
end
