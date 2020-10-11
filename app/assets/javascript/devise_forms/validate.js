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
