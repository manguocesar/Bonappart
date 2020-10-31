var BookingForm = {
  validate: function() {
    var requiredRule = {
      required: true
    };

  $('#bookings_form').validate({
    errorElement: 'div',
    errorClass: 'is-invalid text-danger',

    rules: {
      "booking[start_date]": requiredRule,
      "booking[end_date]": requiredRule
    },

    messages: {
      "booking[start_date]": 'Please select start date',
      "booking[end_date]": 'Please select end date'
    }
  });
  }
}

var FilterBooking = {
  result: function (){
    $('.filter-bookings').click(function () {
      $.ajax({
        type: "GET",
        url: '/student_bookings',
        dataType: 'script',
        data: {
          status: $('#status').val(),
          start_date: $('.at-startdate').val(),
          end_date: $('.at-enddate').val(),
        }
      });
    });
  }
}
