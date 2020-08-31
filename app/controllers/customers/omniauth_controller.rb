class Customers::OmniauthController < ApplicationController
    #facebook callback
    def facebook
        @customer = Customer.create_from_provider_data(request.env['omniauth.auth'])
        if @customer.persisted?
          sign_in_and_redirect @customer
        else
          flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
          redirect_to new_customer_registration_url
        end 
    end



#google callback
     def google_oauth2
        @customer = Customer.create_from_google_data(request.env['omniauth.auth'])
        if @customer.persisted?
          sign_in_and_redirect @customer
        else
          flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
          redirect_to new_customer_registration_url
        end 
     end

     # twitter callback
 def twitter
    @customer = Customer.create_from_twitter_data(request.env['omniauth.auth'])
    if @customer.persisted?
      sign_in_and_redirect @customer
    else
      flash[:error] = 'There was a problem signing you in through Twitter. Please register or try signing in later.'
      redirect_to new_customer_registration_url
    end 
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
    redirect_to new_customer_registration_url
  end
end
