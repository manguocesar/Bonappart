var PaymentForm = {
  validate: function() {
    var requiredRule = {
      required: true
    };

  $('#state, #payment_type').on('change', function () {
    const selector = $(this).attr('id');
    if ($(this).val() == "") {
      $(this).valid();
      if(selector == 'state'){
        $('#city').valid();
      }
    } else {
      if(selector == 'state'){
        $('#city').removeClass('is-invalid text-danger');
        $('#city-error').remove();
        $('#state-error').remove();
      }
      $(this).parent('div').removeClass('is-invalid text-danger');
      $(this).removeClass('is-invalid text-danger');
      $(`#${selector}-error`).remove();
    }
  });

  $('#stripe-form').validate({
    errorElement: 'div',
    errorClass: 'is-invalid text-danger',

    errorPlacement: function (error, element) {
      if (element.is('select')) {
        var parent = element.parent();
        error.insertAfter(parent);
      } else if (element.attr('type') == "radio") {
        var parentDiv = element.parent().parent();
        parentDiv.append(error);
      } else {
        error.insertAfter(element);
      }
    },

    rules: {
      "payment[payment_type]": requiredRule,
      "payment[amount]": requiredRule,
      "[address][area]": requiredRule,
      "[address][postal_code]": requiredRule,
      "address[state]": requiredRule,
      "address[city]": requiredRule
    },

    messages: {
      "payment[payment_type]": 'Please select payment type',
      "payment[amount]": 'Please enter amount',
      "[address][area]": 'Please enter area',
      "[address][postal_code]": 'Please enter postal code',
      "address[state]": 'Please select state',
      "address[city]": 'Please select city'
    },
  });
  }
}
