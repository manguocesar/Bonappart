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

Setting.find_or_create_by(user_name: 'kenan3patel@gmail.com') do |setting|
  setting.address = 'smtp.gmail.com'
  setting.port = '587'
  setting.domain = 'gmail.com'
  setting.password = 'jigarshah8000'
  setting.save
end
puts 'Setting created with default Email'
