class RemoveStockJob < ApplicationJob
    queue_as :default

    def perform(order_id)   
        puts "Working"
        # Invoice.biller_invoice(invoice_no)
        Order.handle_inventory(order_id)
    end
end
  