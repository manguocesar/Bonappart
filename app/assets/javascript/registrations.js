//= require common
//= require login

$(document).ready(function () {
  $(".preloader-outer").delay(500).fadeOut();
  $(".at-preloader-holder").delay(200).fadeOut("slow");
})

RegisterForm = {
  validate: function (edit_profile_called) {
    var requiredRule = {
      required: true,
    };

    var requiredLettersOnly = {
      required: true,
      lettersonly: true
    };

    var notRequired = {
      required: false
    };

    var phoneValidation = {
      required: true,
      PHONE_NUMBER: true
    };

    var emailValidation = {
      required: true,
      CUSTOM_EMAIL: true
    };

    var confirmRules = {
      required: true,
      equalTo: '#password'
    };

    var can_pw_leave_blank = edit_profile_called && (edit_profile_called === true || edit_profile_called == 'true')


    $('#edit_user').validate({
      errorClass: 'is-invalid text-danger',
      errorElement: 'div',

      errorPlacement: function (error, element) {
        if (element.attr('type') == 'checkbox') {
          var parent = element.parent();
          error.insertAfter(parent);
        } else {
          error.insertAfter(element);
        }
      },

      rules: {
        "user[firstname]": requiredLettersOnly,
        "user[lastname]": requiredLettersOnly,
        "user[username]": requiredRule,
        "user[phone_no]": phoneValidation,
        "user[email]": emailValidation,
        "user[password]": can_pw_leave_blank ? notRequired : requiredRule,
        "user[password_confirmation]": can_pw_leave_blank ? notRequired : confirmRules,
        "user[terms_of_service]": requiredRule
      },

      messages: {
        "user[firstname]": 'Please enter first name',
        "user[lastname]": 'Please enter last name',
        "user[username]": 'Please enter user name',
        "user[phone_no]": 'Please enter phone number',
        "user[email]": 'Please enter email',
        "user[password]": 'Please enter password',
        "user[password_confirmation]": {
          required: 'Please enter password again',
          confirm: 'Password confirmation is same as password'
        },
        "user[terms_of_service]": 'Please accept terms of service.'
      },

    });
  }
}
