# This service sends an mpesa client MPESA PUSH messsage using order id and phone number
class PushSender < ApplicationService
    # attr_accessor :order
    def initialize(order)
        @order = order
        @service_response = OpenStruct.new(
            status: nil,
            data: nil,
            message: nil,
            error: nil
        )
        # @phone_number = phone_number
    end

    def call
        # check for previous transactions first
        url = URI("https://payme.revenuesure.co.ke/api/index.php")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        form_data = [['function', 'searchTransactions'],['keyword', @order.order_number]]
        request.set_form form_data, 'multipart/form-data'
        response = https.request(request)
        puts response.read_body
        transactions_response = JSON.parse(response.read_body)
        
        if transactions_response["data"].kind_of?(Array)
            transactions_response["data"].each do |transaction|
                if @order.transactions.where(transaction_code: transaction["transaction_code"]).present? 
                    # this transaction is already saved
                else
                    @order.transactions.build(
                        paybill_number: transaction["account_to"],
                        phone_number: transaction["account_from"],
                        transaction_code: transaction["transaction_code"],
                        amount: transaction["amount"],
                        account_reference: transaction["ref"],
                        transaction_description: transaction["TransactionDesc"],
                        full_names: transaction["names"],
                        date: transaction["date"],
                        payment_mode: transaction["payment_mode"]
                    )
                    @order.save!

                end
            end
            @service_response.status = 400
            @service_response.message = "This order already has payments"
            @service_response.error = "Will not receive more money from you"
            return @service_response
        else
            # No previous transactions
            # check for a pending push
            url = URI("https://payme.revenuesure.co.ke/api/index.php")

            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true

            request = Net::HTTP::Post.new(url)
            form_data = [["function", "checkPaymentVerification"], ["account_reference", @order.order_number]]
            request.set_form form_data, "multipart/form-data"

            response = https.request(request)
            response_json = JSON.parse(response.read_body)
            
            if response_json["success"] == false
                # no pending pushes. You can send the push
                url = URI(AdminConfig["payme"])

                https = Net::HTTP.new(url.host, url.port)
                https.use_ssl = true

                request = Net::HTTP::Post.new(url)
                form_data = [["function", "CustomerPayBillOnlinePush"], ["PayBillNumber", AdminConfig["paybill"]], ["Amount", @order.order_subtotal.to_s], ["PhoneNumber", @order.phone_number], ["AccountReference", @order.order_number], ["TransactionDesc", @order.order_number], ["FullNames", "- - -"]]
                request.set_form form_data, "multipart/form-data"
                response = https.request(request)
                puts response.read_body
                response_json = JSON.parse(response.read_body)
                if response_json["success"] == true
                    @service_response.status = 200
                    @service_response.data = response_json
                    @service_response.message = "Push sent, please wait"
                   
                    return @service_response
                else
                    @service_response.status = 400
                    @service_response.error = "unkwown"
                    @service_response.message = "Push not sent"
                end
            else
                # there is a pending push request. please wait
                @service_response.status = 400
                @service_response.message = "Push already sent, please wait"
                @service_response.error = "can't send stk push twice, please wait"
                return @service_response
            end
        end

        
        
        
        # returns an object with push_sent true/false and error for failure reason null if no errors
    end
end