class CreateRentRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rent_rates do |t|
      t.float :net_rate
      t.float :water_charge
      t.float :heating_charge
      t.float :electricity_charge
      t.float :internet_charge
      t.float :insurance_charge
      t.float :deposit_amount
      t.belongs_to :apartment
      t.timestamps
    end
  end
end
