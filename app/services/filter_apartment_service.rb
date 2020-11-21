# frozen_string_literal: true

# Apartment filter service
class FilterApartmentService
  attr_accessor :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
    @apartments = apartment_for_user(current_user)
  end

  # User specific apartments
  def apartment_for_user(current_user)
    # return current_user&.apartments if current_user.present? && current_user.landlord?
    if current_user.present? && current_user.landlord?
      params[:type].present? ? landlord_apartments : current_user.apartments
    else
      Apartment.all
    end
  end

  def landlord_apartments
    case params[:type]
    when 'live_ads' then current_user.subscribed_apartment
    when 'unpaid_ads' then current_user.unsubscribed_apartment
    when 'booked_ads' then current_user.unavailable_apartments
    when 'available_ads' then current_user.available_apartments
    end
  end

  def sort_apartments
    sort_filter(:campus)
    sort_filter(:distance_from_university)
    sort_filter(:rent)
    search_apartments
  end

  # Sort apartments using various sorting parameters
  def sort_filter(field)
    field_params = params.dig(:sort, field)
    return if field_params.blank?

    @apartments = case field
                  when :campus
                    search_apartments.filter_by_campus(field_params)
                  when :distance_from_university
                    filter_apartments_by_distance(field_params)
                  when :rent
                    filter_apartments_by_rent(field_params)
                  end
    @apartments
  end

  def filter_apartments_by_distance(distance_params)
    return search_apartments if distance_params.include?('I do not mind')

    # search_apartments.filter_by_distance_from_university(distance_params)
    case distance_params
    when distance?(distance_params, Constant::LESS_THAN_TEN)
      search_apartments.near(Constant::UNIVERSITY_ADDRESS, 10)
    when distance?(distance_params, Constant::GREATER_THAN_TEN)
      search_apartments.near(Constant::UNIVERSITY_ADDRESS, 20)
    when distance?(distance_params, Constant::OUTSIDE_FONTAINEBLEAU)
      search_apartments.near(Constant::UNIVERSITY_ADDRESS, 55, units: :km)
    else
      search_apartments
    end
  end

  def filter_apartments_by_rent(rent_params)
    return search_apartments if rent_params.blank?

    low_rent = rent_params.split('-').first.squish.delete('€')
    high_rent = rent_params.split('-').last.squish.delete('€')
    search_apartments.filter_by_rent(low_rent, high_rent)
  end

  def search_apartments
    search_filter(:apartment_type)
    search_filter(:month)
    search_filter(:year)
    @apartments
  end

  # Search apartments based on search parameters
  def search_filter(field)
    field_params = params.dig(:search, field)
    return if field_params.blank?

    @apartments = case field
                  when :apartment_type
                    @apartments.filter_by_type(field_params)
                  when :month
                    @apartments.filter_by_month(field_params)
                  when :year
                    @apartments.filter_by_year(field_params)
                  end
    @apartments
  end

  private

  def distance?(distance_params, distance)
    distance_params.include?(distance)
  end
end
