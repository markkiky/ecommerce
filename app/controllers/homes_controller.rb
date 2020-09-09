class HomesController < ApplicationController

    def index
      @notifications = Home.all
      @products = Product.all
    end 

    def new 
        @notificaton = Home.new
    end 

    def create
         @notification = Home.new(notification_params)
        if  @notification.save
            redirect_to contact_path, notice: "Message Sent Successfully!"
        else 
            render :new
        end 
    end 

    private 

    def notification_params
        params.require(:home).permit(:notification_first_name, :notification_last_name, :notification_phone_number, :notification_email, :notification_message)
    end
end
