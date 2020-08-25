class OrderMailer < ApplicationMailer
    default from: "markkaris438@gmail.com"

    def order_payment
        @customer = params[:customer]
        @transaction = params[:transaction]
        @order = params[:order]
        @url = order_success_url(@order.id)
        attachments.inline['photo.png'] = File.read('public/resources/images/email-temp/full-color.png')
        attachments.inline['space.jpg'] = File.read('public/resources/images/email-temp/space.jpg')
        mail(to: @customer.email, subject: 'Order Payment Success')
    end
end