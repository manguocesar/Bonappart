# frozen_string_literal: true

module ApplicationHelper
  def build_alert_classes(alert_type)
    case alert_type.to_sym
    when :notice, :success
      'alert-success'
    when :danger, :error, :alert
      'alert-danger'
    end
  end

  def active_inactive_header_class(name)
    return 'at-navactive' if action_name.eql?(name)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def apartment_type_collection
    ApartmentType.all
  end

  def apartment_type_name(type)
    type.name&.humanize&.pluralize if type.present?
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def date_format(date)
    date.strftime('%B %d, %Y') if date.present?
  end

  def time_format(date)
    date&.strftime('%I:%M %p') if date.present?
  end

  def display_date(date)
    date&.strftime('%d-%m-%Y')
  end

  def booking_path_based_on_role
    if current_user.student?
      my_bookings_path
    elsif current_user.admin?
      admin_bookings_path
    elsif current_user.landlord?
      landlord_bookings_path
    end
  end

  def pagination_params
    ((current_page || 1).to_i - 1) * Constant::PER_PAGE
  end
end
