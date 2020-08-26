class MpesaChannel < ApplicationCable::Channel
  def subscribed
    stream_from "mpesa_channel_#{params[:order_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
