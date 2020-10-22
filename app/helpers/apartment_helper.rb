# frozen_string_literal: true

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
end
