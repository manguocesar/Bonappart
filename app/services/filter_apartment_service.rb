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
    return current_user&.apartments if current_user.present? && current_user.landlord?

    Apartment.all
  end

  def sort_apartments
    sort_filter(:distance_from_university)
    sort_filter(:rent)
    search_apartments
  end

  # Sort apartments using various sorting parameters
  def sort_filter(field)
    field_params = params.dig(:sort, field)
    return if field_params.blank?

    @apartments = case field
                  when :distance_from_university
                    search_apartments.filter_by_distance_from_university(field_params)
                  when :rent
                    filter_by_rent(field_params)
                  end
    @apartments
  end

  def filter_by_rent(rent_params)
    return search_apartments if rent_params.eql?('All')

    rent_params.eql?('Low to High') ? search_apartments.filter_by_rent_asc : search_apartments.filter_by_rent_desc
  end

  def search_apartments
    search_filter(:apartment_type)
    search_filter(:arrival_date)
    search_filter(:departure_date)
    @apartments
  end

  # Search apartments based on search parameters
  def search_filter(field)
    field_params = params.dig(:search, field)
    return if field_params.blank?

    @apartments = case field
                  when :apartment_type
                    @apartments.filter_by_type(field_params)
                  when :arrival_date
                    @apartments.filter_by_departure_date(field_params)
                  when :departure_date
                    @apartments.filter_by_departure_date(field_params)
                  end
    @apartments
  end
end
