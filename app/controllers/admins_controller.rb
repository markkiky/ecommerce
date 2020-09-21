class AdminsController < ApplicationController
    before_action :authenticate_admin!
    def dashboard
        @overall_earnings = Transaction.sum(:amount)
        @mpesa_earnings = Transaction.where(:payment_mode => "MPESA").sum(:amount)
        @card_earnings = Transaction.where(:payment_mode => "CARD").sum(:amount)
        @total_earnings = Transaction.sum(:amount)
        # Order.where('extract(month from created_at)=?', 4)
    end
    
end
