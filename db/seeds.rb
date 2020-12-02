# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
roles = %w[student admin landlord]

roles.each do |role|
  Role.find_or_create_by(name: role)
end
puts 'roles created'

Setting.find_or_create_by(user_name: Rails.application.credentials.dig(:smtp_settings, :user_name)) do |setting|
  setting.address = 'smtp.gmail.com'
  setting.port = '587'
  setting.domain = 'gmail.com'
  setting.password = Rails.application.credentials.dig(:smtp_settings, :user_name)
  setting.save
end
puts 'Setting created with default Email'

if ApartmentType.where(name: 'default').blank?
  listing_fee = { 'Singapore' => 0, 'Fontainebleau' => 100 }
  ApartmentType.campus.each do |type|
    apartment_type = ApartmentType.new
    apartment_type.name = 'default'
    apartment_type.student_booking_fee = 50
    apartment_type.landlord_listing_fee = listing_fee[type.first]
    apartment_type.campus = type.first
    apartment_type.save(validate: false)
  end
end
