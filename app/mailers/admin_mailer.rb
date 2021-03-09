class AdminMailer < ApplicationMailer

    def welcome_email
        @admin = Admin.find(params[:id])
        @url  =  "#{AdminConfig[:default_url_options]}/admin/dashboard" 
        mail(to: @admin.email, subject: "Welcome to #{AdminConfig[:app_name]}")
      end
end
