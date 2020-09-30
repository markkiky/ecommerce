module OrdersHelper
    def setup_customer(customer)
        customer ||= Customer.new
        customer
    end
end
