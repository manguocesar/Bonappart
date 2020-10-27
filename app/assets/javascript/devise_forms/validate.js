LoginForm = {
  validate: function () {
    $('#new_user').validate({
      rules: {
        "user[email]": {
          required: true,
          CUSTOM_EMAIL: true
        },
        "user[password]": {
          required: true,
          minlength: 6
        }
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
ForgotPasswordForm = {
  validate: function () {
    $('#new_password').validate({
      rules: {
        "user[email]": {
          required: true,
          CUSTOM_EMAIL: true
        },
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
ResendConfirmationForm = {
  validate: function () {
    $('#new_confirmation').validate({
      rules: {
        "user[email]": {
          required: true,
          CUSTOM_EMAIL: true
        },
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
RegisterForm = {
  validate: function () {
    $('#new_registration').validate({
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
        }
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

HostForm = RegisterForm