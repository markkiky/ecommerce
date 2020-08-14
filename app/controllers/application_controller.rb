class ApplicationController < ActionController::Base

  
        def after_sign_in_path_for(resource)
          if admin_signed_in?
            admin_dashboard_path
          else
            root_path
          end
        end
    
    private

    def current_user
        @current_user ||= Customer.find_by(id: session[:user_id])
    end

    helper_method :current_user
end
