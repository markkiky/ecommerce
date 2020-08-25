class Order < ApplicationRecord
    has_many :items, class_name: 'OrderItem'
    has_many :transactions, class_name: "Transaction"

    def self.counter
        @orders = Order.all
        year = Date.today.year.to_s
        year = year.slice(2..3)

        month = Date.today.month.to_s
        month = month.ljust(2, "0")

        day = Date.today.day.to_s
        day = day.rjust(2, "0")

        prefix = "O-"

        if @orders.count < 1
            count = "1"
            order_number = "#{prefix}#{year}#{day}-#{month}#{count.rjust(3,0)}"
            return order_number
        elsif 
            last = Order.last
            if last.order_number != nil
                count = last.order_number.split(//).last(3).join.to_i
                count = count + 1
                series = count.to_s
                order_number = "#{prefix}#{year}#{day}-#{month}#{series.rjust(3,0)}"
                return order_number
            else
                count = last.id
                
                count = count.to_s
                order_number = "#{prefix}#{year}#{day}-#{month}#{count.rjust(3, "0")}"
                return order_number
            end
        end

        return order_number
    end
end
