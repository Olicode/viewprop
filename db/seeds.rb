# puts "Cleaning database..."
# Listing.destroy_all
# Booking.destroy_all
require 'faker'

puts "Create users"

5.times do
  User.create!({
                 first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 email: Faker::Internet.free_email,
                 password: 123_123
               })
end

puts "Finished creating users"

puts "Creating listings..."

Listing.create!({
                  title: "Canggu prime location, huge opportunity!",
                  address: "#{Faker::Address.street_address}, Canggu, Bali",
                  description: "3 BR luxury villa",
                  price: 399.000,
                  negotiable: true,
                  instant_booking: true,
                  user: User.all.sample
                })
Listing.create!({
                  title: "Ubud quiet location, huge opportunity!",
                  address: "#{Faker::Address.street_address}, Ubud, Bali",
                  description: "3 BR luxury villa",
                  price: 299.000,
                  negotiable: false,
                  instant_booking: true,
                  user: User.all.sample
                })
Listing.create!({
                  title: "Canggu quiet location, development opportunity!",
                  address: "#{Faker::Address.street_address}, Canggu, Bali",
                  description: "4 BR villa",
                  price: 180.000,
                  negotiable: false,
                  instant_booking: true,
                  user: User.all.sample
                })
Listing.create!({
                  title: "Uluwatu quiet location, ocean view petite apt!",
                  address: "#{Faker::Address.street_address}, Uluwatu, Bali",
                  description: "1 BR luxury apt",
                  price: 280.000,
                  negotiable: false,
                  instant_booking: false,
                  user: User.all.sample
                })

puts "Finished!"
