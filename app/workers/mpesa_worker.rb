class MpesaWorker
    require "uri"
    require "net/http"
    require "timeout"
    include Sidekiq::Worker
    include Sidekiq::Status::Worker
    sidekiq_options retry: false
    # sidekiq_options 
    @@mpesa_timeout = 30
    @@mpesa_retry = 2
    

    def expiration
        @expiration ||= 60*60*24*30 # 30 days
    end
    

    def perform(order_id)
        order = Order.find(order_id)
        url = URI("https://payme.revenuesure.co.ke/api/index.php")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        form_data = [['function', 'checkPaymentVerification'],['account_reference', order.order_number ]]
        request.set_form form_data, 'multipart/form-data'

        response_json = nil
        begin
            # receipt_response = OpenStruct.new(success: false, response: nil, errors: "No payment Found")
            Timeout.timeout(@@mpesa_timeout) do 
               

                

                receipt_response = false
                while receipt_response == false 
                    # receipt_response = BillerManager::BillerReceiptGettor.call(@reference_bill) 
                    # puts receipt_response 
                    response = https.request(request)
                    # puts response.read_body

                    response_json = JSON.parse(response.read_body)
                    # byebug
                    puts response_json
                    if response_json["success"] == false
                        sleep(@@mpesa_retry)
                    else
                        if response_json["data"]["callback_returned"] == "PENDING"
                            sleep(@@mpesa_retry)
                        elsif response_json["data"]["callback_returned"] == "PAID"
                            receipt_response = true
                        elsif response_json["data"]["callback_returned"] == "UNPAID"
                            receipt_response = true
                        end
                    end
                end
                raise Timeout::Error
                
            end
        rescue Timeout::Error
            puts 'Timed out now: '
            puts response_json['success']

            order_controller = OrdersController.new
            order_controller.after_check_payment(order_id, response_json)
            
        end
       
        puts "End of action perform"

       
    end
   
end