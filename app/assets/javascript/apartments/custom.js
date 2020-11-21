var ApartmentForm = {
  validate: function() {
    var requiredRule = {
      required: true
    };

    $('#apartment_apartment_type_id, #apartment_campus, #apartment_month, #apartment_year').on('change', function () {
      const selector = $(this).attr('id');
      if ($(this).val() == "") {
        $(this).valid();
      } else {
        if (selector == "apartment_campus") {
          var selector_value = $(this).val()
          $('#apartment_country').val(selector_value == "Fontainebleau" ? 'France' : selector_value)
        }
        $(this).parent('div').removeClass('is-invalid text-danger');
        $(`#${selector}-error`).remove();
      }
    });

    $('#apartments_form').validate({
      errorElement: 'div',
      errorClass: 'is-invalid text-danger',

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
        "apartment[title]": requiredRule,
        "apartment[description]": requiredRule,
        "apartment[postalcode]": requiredRule,
        "apartment[floor]": requiredRule,
        "apartment[city]": requiredRule,
        "apartment[area]": requiredRule,
        "apartment[apartment_type]": requiredRule,
        "apartment[availability]": requiredRule,
        "apartment[arrival_date]": requiredRule,
        "apartment[month]": requiredRule,
        "apartment[year]": requiredRule,
        "apartment[departure_date]": requiredRule,
        "apartment[total_bedrooms]": requiredRule,
        "apartment[shower_room]": requiredRule,
        "apartment[distance_from_university]": requiredRule,
        "apartment[longitude]": requiredRule,
        "apartment[latitude]": requiredRule,
        "apartment[apartment_type_id]": requiredRule,
        "apartment[campus]": requiredRule,
        "apartment[rent_rate_attributes][net_rate]": requiredRule,
        "apartment[rent_rate_attributes][deposit_amount]": requiredRule
      },

      messages: {
        "apartment[title]": 'Please enter title',
        "apartment[description]": 'Please enter description',
        "apartment[postalcode]": 'Please enter postalcode',
        "apartment[floor]": 'Please enter floor',
        "apartment[city]": 'Please enter city',
        "apartment[area]": 'Please enter area',
        "apartment[month]": 'Please select month',
        "apartment[year]": 'Please select year',
        "apartment[apartment_type]": 'Please enter accomodation type',
        "apartment[availability]": 'Please enter availability',
        "apartment[arrival_date]": 'Please enter arrival date',
        "apartment[departure_date]": 'Please enter departure date',
        "apartment[total_bedrooms]": 'Please enter total bedrooms',
        "apartment[shower_room]": 'Please enter shower room',
        "apartment[distance_from_university]": 'Please enter distance from university',
        "apartment[longitude]": 'Please enter longtitude',
        "apartment[latitude]": 'Please enter latitude',
        "apartment[apartment_type_id]": 'Please select accomodation type',
        "apartment[campus]": 'Please select campus',
        "apartment[rent_rate_attributes][net_rate]": 'Please enter net rate',
        "apartment[rent_rate_attributes][deposit_amount]": 'Please enter deposite amount'

      },
    });
  }
}

var Filter = {
  result: function (){
    if (location.pathname == '/') {
      $('.sort-filter').click(function () {
        data = {
          search: {
            apartment_type: $('input[name="private"]:checked').val(),
            arrival_date: $('.at-startdate').val(),
            departure_date: $('.at-enddate').val(),
          },
          sort: {
            distance_from_university: $('#distance_from_university').val(),
            rent: $('#net_rate').val(),
          },
        },
        window.location.replace("/apartments" + (/\?.+$/, "?" + jQuery.param(data)));
      });
    }
  }
}

// For diaplay map on apartments page
var DisplayMap = {
  mapSettings: function (latlong) {
    // latlong - coordinates and apartment price
    const map = new google.maps.Map(document.getElementById("at-locationmap"), {
      zoom: 10,
      center: new google.maps.LatLng(parseFloat(latlong[0][2]), parseFloat(latlong[0][3])),
      panControl: true,
      zoomControl: true,
      zoomControlOptions: {
        style: google.maps.ZoomControlStyle.SMALL,
        position: google.maps.ControlPosition.LEFT_CENTER
      },
      scaleControl: false,
      streetViewControl: true,
      overviewMapControl: true
    });
    marker = DisplayMap.setMarker(latlong, map)
  },

  // Set marker (pin/nord) on particular location
  setMarker: function (latlong, map) {
    var marker, i;
    var infowindow = new google.maps.InfoWindow();

    for (i = 0; i < latlong.length; i++){
      marker = new google.maps.Marker({
        animation: google.maps.Animation.DROP,
        position: new google.maps.LatLng(parseFloat(latlong[i][2]), parseFloat(latlong[i][3])),
        title: latlong[i][0],
        map,
      });
      google.maps.event.addListener(marker, 'click', (function (marker, i) {
        return function () {
          infowindow.setContent(latlong[i][0]);
          infowindow.setContent("<a href="+latlong[i][4]+"><img src="+ latlong[i][1] +" style=height:60px;width:100px></a><br/><br/><b>Price:</b>"+ latlong[i][0]);
          infowindow.open(map, marker);
          DisplayMap.toggleBounce;
        }
      })(marker, i));
    }
  },

  //  Marker animation
  toggleBounce: function () {
    if (marker.getAnimation() !== null) {
      marker.setAnimation(null);
    } else {
      marker.setAnimation(google.maps.Animation.BOUNCE);
    }
  },
}


function previewFile(input) {
  $('#image_preview img').remove();
  var files = input.files
  if (files && files.length > 0 ) {
    if(files.length > 20){
      $('#image-limit-validation').removeClass('d-none').addClass('d-block');
    } else {
      $('#uploadedImage').addClass('d-none');
      $('#image-limit-validation').removeClass('d-block').addClass('d-none');
      for (var i = 0; i < files.length; i++) {
        $('#image_preview').append("<img src='" + URL.createObjectURL(event.target.files[i]) + "', width='150px', height='100px'>&nbsp&nbsp");
      }
    }
  }
}

function textFieldDisable(event) {
  var input_field = $(`input[name="apartment[rent_rate_attributes][${event.attr('value')}]"`)
  if (event.prop('checked')){
    input_field.attr('disabled', true);
    input_field.val('');
  } else {
    input_field.removeAttr('disabled');
  }
}
