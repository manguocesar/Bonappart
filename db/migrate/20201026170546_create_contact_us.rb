class CreateContactUs < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_us do |t|
      t.integer :status, default: 0
      t.string :message
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :subject

      t.timestamps
    end
  end
end
