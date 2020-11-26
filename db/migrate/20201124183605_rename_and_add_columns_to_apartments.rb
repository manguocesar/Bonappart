class RenameAndAddColumnsToApartments < ActiveRecord::Migration[6.0]
  def up
    rename_column :apartments, :distance_from_university, :distance_from_campus
    add_column :apartments, :duration_from_campus, :integer
    add_column :apartments, :travel_mode, :string, default: 'walking'
  end

  def down
    rename_column :apartments, :distance_from_campus, :distance_from_university
    remove_column :apartments, :duration_from_campus
    remove_column :apartments, :travel_mode
  end
end
