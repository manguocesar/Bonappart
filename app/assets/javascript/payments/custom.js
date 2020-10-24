var PaymentForm = {
  validate: function() {
    var requiredRule = {
      required: true
    };

  $('#stripe-form').validate({
    errorElement: 'div',
    errorClass: 'is-invalid text-danger',

    rules: {
      "payment[payment_type]": requiredRule,
      "payment[amount]": requiredRule,
      "address[area]": requiredRule,
      "address[postal_code]": requiredRule,
      "address[state]": requiredRule,
      "address[city]": requiredRule
    },

    messages: {
      "payment[payment_type]": 'Please select payment type',
      "payment[amount]": 'Please enter amount',
      "address[area]": 'Please enter area',
      "address[postal_code]": 'Please enter postal code',
      "address[state]": 'Please select state',
      "address[city]": 'Please select city'
    },

    errorPlacement: function (error, element) {
      popoverPlacement (error, element);
    }, 

    success: function (label, element) {
      disablePopover(element);
    }
  });
  }
}