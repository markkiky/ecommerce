module CategoriesHelper
    def setup_category(category)
        category ||= Category.new
        category
    end

    def setup_variants(category)
        category ||= Category.new
        category
    end

    def setup_discount(category_id)
        @category = Category.find(category_id)

        discount = @category.update!({
            discount: {
                product_description: '' 
            }

        })
    end
end
