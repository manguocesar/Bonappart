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
          filter: {
            distance_from_university: $('#distance_from_university').val(),
            distance_from_university: $('#distance_from_university').val(),
            arrival_date: $('#arrival-date').val(),
            departure_date: $('#departure-date').val(),
          }
        }
      });
    });
  }
}

// For diaplay map on apartments page
var DisplayMap = {
  mapSettings: function (latlong) {
    // latlong - coordinates and apartment price
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 12,
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
        draggable: true,
        animation: google.maps.Animation.DROP,
        position: new google.maps.LatLng(parseFloat(latlong[i][2]), parseFloat(latlong[i][3])),
        title: latlong[i][0],
        map,
      });
      google.maps.event.addListener(marker, 'click', (function (marker, i) {
        return function () {
          infowindow.setContent(latlong[i][0]);
          infowindow.setContent("<img src="+ latlong[i][1] +" style=height:60px;width:100px><br/><br/><b>Price:</b>"+ latlong[i][0]);
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