# frozen_string_literal: true

module ApartmentHelper
  def coordinates_hash(apartments)
    latlong = []
    apartments.each do |apartment|
      amount = apartment&.rent_rate&.net_rate.to_i
      latlong << [
        amount,
        url_for(apartment.images.first),
        apartment.latitude,
        apartment.longitude,
        apartment_path(apartment)
      ]
    end
    latlong
  end
end
