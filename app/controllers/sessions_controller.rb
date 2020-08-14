class SessionsController < ApplicationController
    def create
        begin
            @user = Customer.from_omniauth(request.env['omniauth.auth'])
            session[:user_id] = @user.id
            flash[:success] = "Welcome, #{@user.name}!"
        rescue
            flash[:warning] = "There was an error while trying to authenticate you..."
        end
        redirect_to root_path
    end

    def destroy
        
        if current_user
          session.delete(:user_id)
          flash[:success] = 'See you!'
        end
        redirect_to customers_path
      end
end