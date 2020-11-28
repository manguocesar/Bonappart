InvoiceForm = {
  validate: function () {
    $('#invoice_form').validate({
      errorClass: 'is-invalid text-danger',
      errorElement: 'div',

      rules: {
        "invoice[invoice_number]": {
          required: true,
        },
        "invoice[amount]": {
          required: true
        },
        "invoice[date]": {
          required: true
        },
        "invoice[status]": {
          required: true
        }
      },

      messages: {
        "invoice[invoice_number]": 'Please Enter Invoice Number',
        "invoice[amount]": 'Please Enter Amount',
        "invoice[date]": 'Please Enter Date',
        "invoice[status]": 'Please Select Status'
      },

    });
  }
};

