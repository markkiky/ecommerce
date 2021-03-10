class CheckPayment < ApplicationService
    def initialize(order)
        @order = order
        @service_response = OpenStruct.new(
            status: nil,
            data: nil,
            message: nil,
            error: nil,
            order_id: nil,
            response_json: nil
        )
        @@mpesa_retry = 1
        @@mpesa_timeout = 45
    end

    def call
        url = URI("https://payme.revenuesure.co.ke/api/index.php")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        form_data = [["function", "checkPaymentVerification"], ["account_reference", @order.order_number]]
        request.set_form form_data, "multipart/form-data"

        response_json = nil
        begin
            Timeout.timeout(@@mpesa_timeout) do
                receipt_response = false
                while receipt_response == false
                    response = https.request(request)
                    response_json = JSON.parse(response.read_body)
                    
                    puts response_json
                    if response_json["success"] == false
                        count = 0
                        while response_json["success"] == false
                            count += 1
                            response = https.request(request)
                            # puts response.read_body
                            response_json = JSON.parse(response.read_body)
                            sleep(@@mpesa_retry)
                            if count > AdminConfig[:mpesa_error_detection].to_i
                                puts "Culprit"
                                receipt_response = true
                                break
                            end
                        end
                    else
                        if response_json["data"]["callback_returned"] == "PENDING"
                            sleep(@@mpesa_retry)
                        elsif response_json["data"]["callback_returned"] == "PAID"
                            # after_check_payment(@order.id, response_json)
                            # if @order.admin_id == nil
                            # render :js => "window.location = '#{order_success_path(@order.id)}'"
                            # else
                            # render :js => "window.location = '#{order_success_admin_path(@order.id)}'"
                            # end
                            receipt_response = true
                        elsif response_json["data"]["callback_returned"] == "UNPAID"
                            receipt_response = true
                        end
                    end
                end
                raise Timeout::Error
            end
        rescue Timeout::Error
            puts "Timed out now: "
            if response_json["success"]
                # gon.response_json = response_json
                # gon.status = response_json["data"]["callback_returned"].downcase
                # gon.order_id = params[:id]
                @service_response.response_json = response_json
                @service_response.status = response_json["data"]["callback_returned"].downcase
                @service_response.order_id = @order.id
                puts "Check Payment Completed Successfully Found"
                return @service_response
            else
                # gon.response_json = "Failed to send push request"
                # gon.status = "404"
                # gon.order_id = params[:id]
                @service_response.response_json =  "Payment Not Found"
                @service_response.status = 404
                @service_response.order_id = @order.id
                puts "Payment Not Found"
                return @service_response
            end
            
        end
    end
end