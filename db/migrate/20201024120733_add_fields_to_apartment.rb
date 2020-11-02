class AddFieldsToApartment < ActiveRecord::Migration[6.0]
  def up
    add_column :apartments, :subscribed, :boolean, default: false
    change_column :apartments, :availability, :boolean, default: true
  end

  def down
    remove_column :apartments, :subscribed
    change_column :apartments, :availability, :boolean
  end
end
