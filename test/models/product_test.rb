require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "should not save product without a category" do
    product = Product.new
    assert false
  end
end
