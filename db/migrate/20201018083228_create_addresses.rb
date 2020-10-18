class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :state
      t.string :country
      t.belongs_to :payment
      t.timestamps
    end
  end
end
