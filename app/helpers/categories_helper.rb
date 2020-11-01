module CategoriesHelper
    def setup_category(category)
        category ||= Category.new
        category
    end

    def setup_sub_category(sub_category)
        sub_category ||= SubCategory.new
        sub_category
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
