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

  def back_to_apartments
    if current_user.admin?
      admin_apartments_path
    elsif current_user.landlord?
      landlord_apartments_path
    else
      apartments_path
    end
  end

  def show_page_apartments
    if current_user.admin?
      admin_apartment_path
    elsif current_user.landlord?
      landlord_apartment_path
    else
      apartment_path
    end
  end

  def subscription_url_for_user(apartment_id)
    current_user.landlord? ?
      new_landlord_subscription_path(apartment_id: apartment_id) :
      new_admin_subscription_path(apartment_id: apartment_id)
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

  def other_amenities_text(amenities)
    "#{amenities.last} #{amenities.first.titleize.pluralize}"
  end

  def apartment_type_image(apartment_type)
    apartment_type.image.attached? ? url_for(apartment_type.image) : image_url('radio-imgs/img-06.jpg')
  end

  def is_included_in_net_rate?(included_fields_array, field)
    included_fields_array.include?(field)
  end

  def active_link_to_tab
    case controller_name
    when 'dashboard'
      'dashboard'
    when 'apartments'
      'apartments'
    when 'apartment_types'
      'apartment_types'
    when 'bookings'
      'bookings'
    when 'invoices'
      'invoices'
    when 'users'
      params['type'] == 'landlord' ? 'landlord' : 'student'
    end
  end
end
