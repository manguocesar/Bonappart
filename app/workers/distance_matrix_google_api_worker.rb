# frozen_string_literal: true

# For fetching distance and walking duration from campus using Google Map API
class DistanceMatrixGoogleApiWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(apartment_id)
    @apartment = Apartment.find_by(id: apartment_id)
    distance_and_duration
  end

  def distance_and_duration
    apartment_latlong = [@apartment&.latitude, @apartment&.longitude]
    origin_latlong = campus_address.join(',')
    destination_latlong = apartment_latlong.join(',')
    result = Google::Maps.route(origin_latlong, destination_latlong, mode: @apartment.travel_mode)
    distance_in_km = two_decimal_precision(result&.distance&.value/1000.00)
    duration_in_min = result&.duration&.value/60
    @apartment.update_columns(distance_from_campus: distance_in_km, duration_from_campus: duration_in_min)
  end

  private

  def two_decimal_precision(value)
    "%.2f" % value
  end

  def campus_address
    # Change code based on campus
    Constant::COORDINATES_OF_FONTAINEBLEAU_CAMPUS
  end
end
