module ProductsHelper
    def setup_product(product)
        product ||= Product.new
        product
    end
end
