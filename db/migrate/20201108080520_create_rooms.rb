class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name_for_student
      t.string :name_for_landlord
      t.references :inquiry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
