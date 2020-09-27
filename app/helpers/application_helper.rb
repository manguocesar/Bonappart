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
end
