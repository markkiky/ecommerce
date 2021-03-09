class SessionsController < ApplicationController
    def create
        if auth != nil
            if auth.provider == "google_oauth2"
                @customer = Customer.from_omniauth(auth)
                @customer.first_name = auth.extra.raw_info.given_name
                @customer.last_name = auth.extra.raw_info.family_name
                @customer.image_url = auth.extra.raw_info.picture
                @customer.uid = auth.uid
                @customer.save
               
            elsif auth.provider == "twitter"

            end
        end
        # begin
        #     @user = Customer.from_omniauth(request.env['omniauth.auth'])
        #     session[:user_id] = @user.id
        #     flash[:success] = "Welcome, #{@user.name}!"
        # rescue
        #     flash[:warning] = "There was an error while trying to authenticate you..."
        # end
        redirect_to root_path
    end

    def destroy
        if current_admin != nil
            sign_out current_admin
            flash[:success] = 'See you!'
            redirect_to new_admin_session_path
        else
            sign_out current_admin
            flash[:success] = "Logged Out"
            redirect_to new_admin_session_path
        end
    end

    def omniauth
        if auth != nil
            if auth.provider == "google_oauth2"
                @customer = Customer.from_omniauth(auth)
                @customer.first_name = auth.extra.raw_info.given_name
                @customer.last_name = auth.extra.raw_info.family_name
                @customer.image_url = auth.extra.raw_info.picture
                @customer.uid = auth.uid
                @customer.save
                session[:customer_id] = @customer.id
                sign_in @customer
                redirect_to root_path
            elsif auth.provider == "twitter"
                @customer = Customer.from_omniauth(auth)
                # @customer.first_name = auth.extra.raw_info.given_name
                # @customer.last_name = auth.extra.raw_info.family_name
                # @customer.image_url = auth.extra.raw_info.picture
                @customer.uid = auth.uid
                @customer.save
                session[:customer_id] = @customer.id
                sign_in @customer
                redirect_to root_path
                # auth.extra.raw_info.email
            elsif auth.provider == 'facebook'
                @customer = Customer.from_omniauth(auth)
                name =  auth.info.name.split
                @customer.first_name = name.first
                @customer.last_name = name.last
                @customer.uid = auth.uid
                @customer.provider = auth.provider
                @customer.save!
                session[:customer_id] = @customer.id
                sign_in @customer
                redirect_to root_path
            end
        end
       
    end  

    private  

    def auth
        request.env['omniauth.auth']
    end
end