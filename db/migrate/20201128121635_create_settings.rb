class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.string :address
      t.string :port
      t.string :domain
      t.string :user_name
      t.string :password
      t.timestamps
    end
  end
end
