class CreateInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiries do |t|
      t.string :message
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
