import consumer from "./consumer"
var response_json 
consumer.subscriptions.create("TestChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    // alert("test")
    // this.send({ message: 'Client is live' })
    console.log("Connected to test");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // alert(data.message);
    
    // console.log(data.paybill);
    // const paybill = document.getElementById("paybill");
    // const phone = document.getElementById("phone");
    // const transaction_code = document.getElementById('transaction_code');
    // paybill.append(data.paybill);
    // phone.append(data.phone);
    // transaction_code.append(data.transaction_code);
    // $("#order_success_btn").attr('href', "https://shop.arigiene.com/order_success/"+order_id);
    // $("#mpesaModal").modal("hide");
    $('#mpesaNumber').remove();
    var status = data.status
    var order_id = data.order_id
    var payment_info = null
    var transaction_info = null;
    switch (status) {
      case "unpaid":
        payment_info = data.response_json.data
        $("#paymentModalLabel").text(payment_info.message)
        $(".paid").addClass("d-none")
        $(".pending").addClass('d-none')
        break;

      case 'paid':
        transaction_info = data.response_json.data
        payment_info = data.response_json.data2
        const paybill = payment_info.account_to
        const phone = payment_info.account_from
        const transaction_code = payment_info.transaction_code
        $("#paymentModalLabel").text(transaction_info.message)
        $("#paybill").append(paybill)
        $("#phone").append(phone)
        $("#transaction_code").append(transaction_code)
        $("#order_success_btn").attr('href', "http://localhost:3000/order_success/"+order_id);
        // $("#paid").addClass("d-none")
        $(".unpaid").addClass('d-none')
        
        $(".pending").addClass('d-none')
        break;

      case 'pending':
        transaction_info = data.response_json.data
        $("#paymentModalLabel").text(transaction_info.message)
        $(".paid").addClass("d-none")
        $(".unpaid").addClass('d-none')
        break;
    
      default:
        break;
    }
    console.log(data)
    // response_json = data
    // $("#paymentModalLabel").val(payment_info);
    $("#paymentModal").modal('show');
    $("#mpesaModal").modal("toggle");
  }
});
