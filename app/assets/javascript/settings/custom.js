SettingForm = {
  validate: function () {
    $('#setting_form').validate({
      errorClass: 'is-invalid text-danger',
      errorElement: 'div',

      rules: {
        "setting[address]": {
          required: true
        },
        "setting[domain]": {
          required: true
        },
        "setting[port]": {
          required: true
        },
        "setting[user_name]": {
          required: true
        },
        "setting[password]": {
          required: true
        }
      },
      messages: {
        "setting[address]": 'Please Enter Address',
        "setting[domain]": 'Please Enter Domain',
        "setting[port]": 'Please Enter Port',
        "setting[user_name]": 'Please Enter User Name',
        "setting[password]": 'Please Enter Password'
        }
    });
  }
}
