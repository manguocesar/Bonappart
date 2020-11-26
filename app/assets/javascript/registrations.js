//= require common
//= require login

$(document).ready(function () {
  $(".preloader-outer").delay(500).fadeOut();
  $(".at-preloader-holder").delay(200).fadeOut("slow");
  RegisterForm.validate();
})

RegisterForm = {
  validate: function () {
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
        "user[email]": {
          required: true,
          CUSTOM_EMAIL: true
        },
        "user[firstname]": {
          required: true,
          lettersonly: true
        },
        "user[lastname]": {
          required: true,
          lettersonly: true
        },
        "user[phone_no]": {
          required: true,
          PHONE_NUMBER: true
        },
        "user[username]": {
          required: true
        },
        "user[terms_of_service]": {
          required: true
        }
      },

    });
  }
}
DatePicker = {
  init: function () {
    new Lightpick({
      field: document.getElementById('birthdate'),
      onSelect: function (date) {
        document.getElementById('birthdate').innerHTML = date.format('Do MMMM YYYY');
      }
    });
  }
}
