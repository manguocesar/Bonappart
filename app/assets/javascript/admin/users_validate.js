var UserForm = {
  validate: function (edit_profile_called) {
    var requiredRule = {
      required: true
    };

    var notRequired = {
      required: false
    };

    var confirmRules = {
      required: true,
      equalTo: '#password'
    };

    var can_pw_leave_blank = edit_profile_called && (edit_profile_called === true || edit_profile_called == 'true')

    $('#new_user, #user_edit_form').validate({
      errorElement: 'div',
      errorClass: 'is-invalid text-danger',

      errorPlacement: function (error, element) {
        if (element.is('select')) {
          var parentDiv = element.parent('div');
          error.insertAfter(parentDiv);
        } else if (element.attr('type') == "radio") {
          var parentDiv = element.parent().parent('div');
          parentDiv.append(error);
        } else {
          error.insertAfter(element);
        }
      },

      rules: {
        "user[firstname]": requiredRule,
        "user[lastname]": requiredRule,
        "user[username]": requiredRule,
        "user[phone_no]": requiredRule,
        "user[birthdate]": requiredRule,
        "user[gender]": requiredRule,
        "user[address]": requiredRule,
        "user[email]": requiredRule,
        "user[password]": can_pw_leave_blank ? notRequired : requiredRule,
        "user[password_confirmation]": can_pw_leave_blank ? notRequired : confirmRules,
        "roles": requiredRule,
      },

      messages: {
        "user[firstname]": 'Please enter first name',
        "user[lastname]": 'Please enter last name',
        "user[username]": 'Please enter user name',
        "user[phone_no]": 'Please enter phone number',
        "user[birthdate]": 'Please enter birth date',
        "user[gender]": 'Please select gender',
        "user[address]": 'Please enter address',
        "user[email]": 'Please enter email',
        "user[password]": 'Please enter password',
        "user[password_confirmation]": {
          required: 'Please enter password again',
          confirm: 'Password confirmation is same as password'
        },
        "roles": 'Please select a role'
      },
    });
  }
}
