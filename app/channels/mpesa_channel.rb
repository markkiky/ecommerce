class MpesaChannel < ApplicationCable::Channel  
    def subscribed
        stream_from 'mpesa'
    end
end  
