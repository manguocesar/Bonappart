var ApartmentTypeForm = {
  validate: function () {
    var requiredRule = {
      required: true
    };

    $('#apartment_type_form').validate({
      errorElement: 'div',
      errorClass: 'is-invalid text-danger',

      rules: {
        "apartment_type[name]": requiredRule,
        "apartment_type[amount]": requiredRule,
        "apartment_type[image]": requiredRule,
      },

      messages: {
        "apartment_type[name]": 'Please enter name',
        "apartment_type[amount]": 'Please enter amount',
        "apartment_type[image]": 'Please select image',
      },
    });
  }
}