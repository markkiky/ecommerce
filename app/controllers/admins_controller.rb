class AdminsController < ApplicationController
    before_action :authenticate_admin!
    def dashboards
        
    end
end
