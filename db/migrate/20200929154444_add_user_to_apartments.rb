class AddUserToApartments < ActiveRecord::Migration[6.0]
  def change
    add_reference :apartments, :user, null: false, foreign_key: true
  end
end
