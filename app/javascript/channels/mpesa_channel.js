import consumer from "./consumer";

// a user who is receiving data from this mpesa_channel
// a subscription connects the user to a certain channel
document.addEventListener('turbolinks:load', () => {
  
  const element = document.getElementById("test");
  var order_id = null;
  // check if order_id div has something, means not on that page
  if (typeof element !== 'undefined' && element !== null) {
    
    order_id = element.getAttribute('data-order-id');
    consumer.subscriptions.create(
      { channel: "MpesaChannel", order_id: order_id },
      {
        connected() {
          console.log("Connected to mpesa channel");
          // alert("now connected: mpesa_channel: "+ order_id);
          // Called when the subscription is ready for use on the server
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          // Called when there's incoming data on the websocket for this channel
          console.log(data.paybill);
          const paybill = document.getElementById("paybill");
          const phone = document.getElementById("phone");
          const transaction_code = document.getElementById('transaction_code');
          paybill.append(data.paybill);
          phone.append(data.phone);
          transaction_code.append(data.transaction_code);
          $("#order_success_btn").attr('href', "https://shop.arigiene.com/order_success/"+order_id);
          $("#paymentModal").modal('show');
          // ActionCable.server.broadcast 'mpesa_channel', message: "Bitches be ware"
        },
      }
    );
  } else {

  }
  // console.log(element);
  // const order_id = element.getAttribute('data-order-id');
  // console.log("The room id is: ")

})

