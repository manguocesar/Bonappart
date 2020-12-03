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
    elsif current_user.present? && current_user.admin?
      params[:type].present? ? admin_apartments : Apartment.all
    else
      Apartment.subscribed
    end
  end

  def admin_apartments
    case params[:type]
    when 'live_ads' then Apartment.subscribed
    when 'all_ads' then Apartment.all
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
    sort_filter(:distance_from_campus)
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
                  when :distance_from_campus
                    filter_apartments_by_distance(field_params)
                  when :rent
                    filter_apartments_by_rent(field_params)
                  end
    @apartments
  end

  def filter_apartments_by_distance(distance_params)
    return search_apartments if distance_params.include?('Not important')

    # search_apartments.filter_by_distance_from_campus(distance_params)
    case distance_params
    when Constant::DISTANCE_FROM_CAMPUS[0]
      search_apartments.where('duration_from_campus <= ?', 10)
    when Constant::DISTANCE_FROM_CAMPUS[1]
      search_apartments.where('duration_from_campus >= :duration AND distance_from_campus <= :distance', duration: 10, distance: two_decimal_precision('55'))
    when Constant::DISTANCE_FROM_CAMPUS[2]
      search_apartments.where('distance_from_campus >= ?', two_decimal_precision('55'))
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

  def two_decimal_precision(value)
    '%.2f' % value
  end
end
