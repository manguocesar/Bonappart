InvoiceForm = {
  validate: function () {
    $('#invoiceForm').validate({
      errorClass: 'is-invalid text-danger',
      errorElement: 'div',
      errorPlacement: function (error, element) {
        if (element.is('select')) {
          var parentDiv = element.parent('div');
          error.insertAfter(parentDiv);
          // parentDiv.addClass("is-invalid text-danger");
        } else {
          error.insertAfter(element);
        }
      },

      rules: {
        "invoice[amount]": {
          required: true
        },
        "invoice[date]": {
          required: true
        },
        "invoice[status]": {
          required: true
        },
        "invoice[user_id]": {
          required: true
        },
        "invoice[apartment_id]": {
          required: true
        },
        "invoice[vat_rate]": {
          required: true
        }
      },

      messages: {
        "invoice[amount]": 'Please Enter Amount',
        "invoice[date]": 'Please Enter Date',
        "invoice[status]": 'Please Select Status',
        "invoice[user_id]": 'Please Select Landlord',
        "invoice[apartment_id]": 'Please Select Property',
        "invoice[vat_rate]": 'Please Enter VAT Rate'
      },
    });
  }
};

Property = {
  init: function() {
    $('#landlordUser').change(function () {
      var properties = $('#properties');
      var landlord_name = $(this).val()
      $.getJSON('/admin/landlord_properties/' + landlord_name, function (data) {
        properties.empty();
        $.each(data, function (i, ele) {
        properties.append($("<option></option>")
          .attr("value", ele[1])
          .text(ele[0]));
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
