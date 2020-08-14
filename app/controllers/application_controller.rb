class ApplicationController < ActionController::Base
    
    private

    def current_user
        @current_user ||= Customer.find_by(id: session[:user_id])
    end

    helper_method :current_user
end
