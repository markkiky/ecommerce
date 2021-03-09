class CustomerMailer < ApplicationMailer
    default from: "markkaris438@gmail.com"
    
    def welcome_email
      @customer = Customer.find(params[:id])
      @url  =  AdminConfig[:default_url_options] 
      mail(to: @customer.email, subject: "Welcome to #{AdminConfig[:app_name]}")
    end
end
