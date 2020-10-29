# frozen_string_literal: true

# Apartment Helper
module ApartmentHelper
  def coordinates_hash(apartments)
    latlong = []
    apartments.each do |apartment|
      latlong << [
        "500",
        url_for(apartment.images.first),
        apartment.latitude,
        apartment.longitude
      ]
    end
    latlong
  end

  def check_availability(apartment)
    if apartment.availability?
      "Available by #{apartment.departure_date_availabilty}"
    else
      'Not Available'
    end
  end

  def apartment_types_collection
    ApartmentType.pluck(:name).map(&:humanize)
  end
end
