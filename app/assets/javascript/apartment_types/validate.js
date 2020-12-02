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
        "apartment_type[landlord_listing_fee]": requiredRule,
        "apartment_type[student_booking_fee]": requiredRule,
        "apartment_type[image]": requiredRule,
      },

      messages: {
        "apartment_type[name]": 'Please enter name',
        "apartment_type[landlord_listing_fee]": 'Please enter landlord listing fee',
        "apartment_type[student_booking_fee]": 'Please enter student booking fee',
        "apartment_type[image]": 'Please select image',
      },
    });
  }
}