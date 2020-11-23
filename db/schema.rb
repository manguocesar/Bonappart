# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_20_175343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "area"
    t.string "postal_code"
    t.string "city"
    t.string "state"
    t.string "country"
    t.bigint "payment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_id"], name: "index_addresses_on_payment_id"
  end

  create_table "apartment_types", force: :cascade do |t|
    t.string "name"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "apartments", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "postalcode"
    t.string "floor"
    t.string "city"
    t.string "country"
    t.string "area"
    t.boolean "availability", default: true
    t.datetime "arrival_date"
    t.datetime "departure_date"
    t.integer "total_bedrooms"
    t.string "shower_room"
    t.string "distance_from_university"
    t.string "other_facilities"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "booking_id"
    t.string "virtual_visit_link"
    t.boolean "subscribed", default: false
    t.bigint "apartment_type_id"
    t.string "campus"
    t.string "month"
    t.string "year"
    t.index ["apartment_type_id"], name: "index_apartments_on_apartment_type_id"
    t.index ["booking_id"], name: "index_apartments_on_booking_id"
    t.index ["user_id"], name: "index_apartments_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "contact_us", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "message"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "subject"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "message"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "apartment_id", null: false
    t.index ["apartment_id"], name: "index_inquiries_on_apartment_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "invoice_number"
    t.datetime "date"
    t.float "amount"
    t.integer "status", default: 0
    t.bigint "booking_id"
    t.bigint "subscription_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_invoices_on_booking_id"
    t.index ["subscription_id"], name: "index_invoices_on_subscription_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "payment_type"
    t.float "amount"
    t.integer "status"
    t.text "remarks"
    t.string "stripe_token"
    t.bigint "booking_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "subscription_id"
    t.index ["booking_id"], name: "index_payments_on_booking_id"
    t.index ["subscription_id"], name: "index_payments_on_subscription_id"
  end

  create_table "rent_rates", force: :cascade do |t|
    t.float "net_rate"
    t.float "water_charge"
    t.float "heating_charge"
    t.float "electricity_charge"
    t.float "internet_charge"
    t.float "insurance_charge"
    t.float "deposit_amount"
    t.bigint "apartment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "included_in_net_rate", default: [], array: true
    t.index ["apartment_id"], name: "index_rent_rates_on_apartment_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name_for_student"
    t.string "name_for_landlord"
    t.bigint "inquiry_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inquiry_id"], name: "index_rooms_on_inquiry_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "started_at"
    t.date "expired_at"
    t.bigint "user_id", null: false
    t.bigint "apartment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["apartment_id"], name: "index_subscriptions_on_apartment_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.string "username", default: "", null: false
    t.string "phone_no"
    t.datetime "birthdate"
    t.string "gender"
    t.text "address"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "apartments", "apartment_types"
  add_foreign_key "apartments", "bookings"
  add_foreign_key "apartments", "users"
  add_foreign_key "inquiries", "apartments"
  add_foreign_key "invoices", "bookings"
  add_foreign_key "invoices", "subscriptions"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "payments", "subscriptions"
  add_foreign_key "rooms", "inquiries"
  add_foreign_key "subscriptions", "apartments"
  add_foreign_key "subscriptions", "users"
end
