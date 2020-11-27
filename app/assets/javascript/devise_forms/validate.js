LoginForm = {
  validate: function () {
    $('#new_user').validate({
      errorClass: 'is-invalid text-danger',
      errorElement: 'div',

      rules: {
        "user[login]": {
          required: true,
        },
        "user[password]": {
          required: true,
          minlength: 6
        }
      },

    });
  }
}
ForgotPasswordForm = {
  validate: function () {
    $('#new_password').validate({
      errorClass: 'is-invalid text-danger',
      errorElement: 'div',

      rules: {
        "user[email]": {
          required: true,
          CUSTOM_EMAIL: true
        },
      },

    });
  }
}
ResendConfirmationForm = {
  validate: function () {
    $('#new_confirmation').validate({
      errorClass: 'is-invalid text-danger',
      errorElement: 'div',

      rules: {
        "user[email]": {
          required: true,
          CUSTOM_EMAIL: true
        },
      },

    });
  }
}
RegisterForm = {
  validate: function () {
    $('#new_registration').validate({
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
        "user[password]": {
          required: true,
          minlength: 6
        },
        "user[password_confirmation]": {
          required: true,
          minlength: 6,
          equalTo: '#password'
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

HostForm = RegisterForm
