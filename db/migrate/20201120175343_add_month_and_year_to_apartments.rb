class AddMonthAndYearToApartments < ActiveRecord::Migration[6.0]
  def up
    add_column :apartments, :month, :string
    add_column :apartments, :year, :string
  end

  def down
    remove_column :apartments, :month, :string
    remove_column :apartments, :year, :string
  end
end
