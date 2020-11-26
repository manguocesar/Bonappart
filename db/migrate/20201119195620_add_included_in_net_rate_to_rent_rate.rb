class AddIncludedInNetRateToRentRate < ActiveRecord::Migration[6.0]
  def up
    add_column :rent_rates, :included_in_net_rate, :string, array: true, default: []
  end

  def down
    remove_column :rent_rates, :included_in_net_rate
  end
end
