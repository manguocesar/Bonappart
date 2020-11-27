# frozen_string_literal: true

# RentRate model
class RentRate < ApplicationRecord
  # Associations
  belongs_to :apartment

  INCLUDED_IN_NET_RATE_FIELDS = %w[water_charge heating_charge electricity_charge internet_charge insurance_charge]
end
