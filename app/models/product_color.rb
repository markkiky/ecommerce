class ProductColor < ApplicationRecord
  belongs_to :product, class_name: "Product", foreign_key: "product_id"
  belongs_to :color, class_name: "Color", foreign_key: "color_id"
end
