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

Property = {
  fillValues: function() {
    $('#landlordUser').change(function () {
      var properties = $('#properties');
      var landlord_name = $(this).val().split(' ')[0]
      $.getJSON('/admin/landlord_properties/' + landlord_name, function (data) {
        properties.empty();
        $.each(data, function (i, ele) {
        properties.append($("<option></option>")
          .attr("value", ele)
          .text(ele));
        });
        $('.selectpicker').selectpicker('refresh');
      });
    });
  }
};

Calender = {
  init: function() {
    new Lightpick({
      field: document.getElementById('date'),
      onSelect: function (date) {
        document.getElementById('date').innerHTML = date.format('Do MMMM YYYY');
      }
    });
  }
};
