# frozen_string_literal: true

module BookingsHelper
  # Display my dashboard or my booking based on current user role
  def mydashboard_or_mybookings
    current_user.student? ? ['My Bookings', my_bookings_path] : admin_or_landlord_dashboard
  end

  def admin_or_landlord_dashboard
    path = current_user.landlord? ? landlord_dashboard_path : admin_dashboard_path
    ['My Dashboard', path]
  end
end
