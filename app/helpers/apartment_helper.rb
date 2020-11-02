# frozen_string_literal: true

# Apartment Helper
module ApartmentHelper
  def coordinates_hash(apartments)
    latlong = []
    apartments.each do |apartment|
      amount = apartment.net_rent
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

  def apartment_types_array
    ApartmentType.pluck(:name, :id).uniq
  end
end
