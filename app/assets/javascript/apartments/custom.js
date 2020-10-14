var ApartmentForm = {
  validate: function() {
    var requiredRule = {
      required: true
    };

  $('#apartments_form').validate({
    errorElement: 'div',
    errorClass: 'is-invalid text-danger',

    rules: {
      "apartment[title]": requiredRule,
      "apartment[description]": requiredRule,
      "apartment[postalcode]": requiredRule,
      "apartment[floor]": requiredRule,
      "apartment[city]": requiredRule,
      "apartment[country]": requiredRule,
      "apartment[area]": requiredRule,
      "apartment[apartment_type]": requiredRule,
      "apartment[availability]": requiredRule,
      "apartment[arrival_date]": requiredRule,
      "apartment[departure_date]": requiredRule,
      "apartment[total_bedrooms]": requiredRule,
      "apartment[shower_room]": requiredRule,
      "apartment[distance_from_university]": requiredRule,
      "apartment[other_facilities]": requiredRule,
      "apartment[longitude]": requiredRule,
      "apartment[latitude]": requiredRule

    },

    messages: {
      "apartment[title]": 'Please enter title',
      "apartment[description]": 'Please enter description',
      "apartment[postalcode]": 'Please enter postalcode',
      "apartment[floor]": 'Please enter floor',
      "apartment[city]": 'Please enter city',
      "apartment[country]": 'Please enter country',
      "apartment[area]": 'Please enter area',
      "apartment[apartment_type]": 'Please enter accomodation type',
      "apartment[availability]": 'Please enter availability',
      "apartment[arrival_date]": 'Please enter arrival date',
      "apartment[departure_date]": 'Please enter departure date',
      "apartment[total_bedrooms]": 'Please enter total bedrooms',
      "apartment[shower_room]": 'Please enter shower room',
      "apartment[distance_from_university]": 'Please enter distance from university',
      "apartment[other_facilities]": 'Please enter other facilities',
      "apartment[longitude]": 'Please enter longtitude',
      "apartment[latitude]": 'Please enter latitude'
    },
  });
  }
}

var Filter = {
  result: function (){
    $('.sort-filter').click(function () {
      $.ajax({
        type: "GET",
        url: '/apartments',
        dataType: 'script',
        data: {
          search: {
            apartment_type: $('#apartment_type').val(),
            arrival_date: $('#arrival-date').val(),
            departure_date: $('#departure-date').val(),
          },
          sort: {
            distance_from_university: $('#distance_from_university').val(),
            rent: $('#rent').val(),
          }
        }
      });
    });
  }
}
