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
