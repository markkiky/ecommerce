module CategoriesHelper
    def setup_category(category)
        category ||= Category.new
        category
    end
end
