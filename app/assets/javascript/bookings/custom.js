var Booking = {
  pay_now: function (){
    $('.pay_now').click(function () {
      $.ajax({
        type: "POST",
        url: "/card",
        dataType: 'script',
        data: {
          booking: {
            status: $('#booking_status').val(),
            start_date: $('#start-date').val(),
            consignee: $('#end-date').val(),
          }
        }
      });
    });
  }
}
