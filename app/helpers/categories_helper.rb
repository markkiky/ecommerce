module CategoriesHelper
    def setup_category(category)
        category ||= Category.new
        category
    end

    def setup_sub_category(sub_category)
        sub_category ||= SubCategory.new
        sub_category
    end
end
