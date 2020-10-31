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
    ApartmentType.order(:name)
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def date_format(date)
    date.strftime('%B %d, %Y')
  end
end
