# frozen_string_literal: true

module BookingsHelper
  # Display my dashboard or my booking based on current user role
  def mydashboard_or_mybookings
    current_user.student? ? ['My Bookings', student_bookings_path] : ['My Dashboard', dashboard_index_path]
  end
end
