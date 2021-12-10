# puts "Cleaning database..."
# Listing.destroy_all
# Booking.destroy_all
require 'faker'
require 'database_cleaner/active_record'

DatabaseCleaner.allow_production = true
DatabaseCleaner.allow_remote_database_url = true
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

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
                  address: "Canggu, Bali",
                  description: "3 BR luxury villa",
                  price: 399.000,
                  negotiable: true,
                  instant_booking: true,
                  user: User[0]
                })
Listing.create!({
                  title: "Ubud quiet location, huge opportunity!",
                  address: "Ubud, Bali",
                  description: "3 BR luxury villa",
                  price: 299.000,
                  negotiable: false,
                  instant_booking: true,
                  user: User[1]
                })
Listing.create!({
                  title: "Canggu quiet location, development opportunity!",
                  address: "Canggu, Bali",
                  description: "4 BR villa",
                  price: 180.000,
                  negotiable: false,
                  instant_booking: true,
                  user: User[2]
                })
Listing.create!({
                  title: "Uluwatu quiet location, ocean view petite apt!",
                  address: "Uluwatu, Bali",
                  description: "1 BR luxury apt",
                  price: 280.000,
                  negotiable: false,
                  instant_booking: false,
                  user: User[3]
                })

puts "Finished creating listings!"

puts "Create bookings"

Booking.create!({
                  date: "12-04-2021",
                  start_time: "9:30",
                  end_time: "10:00",
                  status: "Accepted",
                  listing: Listing[3],
                  user: User[0]
                })
Booking.create!({
                  date: "12-12-2021",
                  start_time: "10:30",
                  end_time: "11:00",
                  status: "Pending",
                  listing: Listing[2],
                  user: User[1]
                })
Booking.create!({
                  date: "14-07-2021",
                  start_time: "7:30",
                  end_time: "08:00",
                  status: "Rejected",
                  listing: Listing[3],
                  user: User[2]
                })
Booking.create!({
                  date: "12-12-2021",
                  start_time: "13:30",
                  end_time: "14:00",
                  status: "Accepted",
                  listing: Listing[0],
                  user: User[3]
                })

puts "Finish creating Bookings"

puts "Creating offers"

Offer.create!({
                final_price: 139_000,
                buyer_confirmed: true,
                seller_confirmed: false,
                listing: Listing[3],
                user: User[0]
              })
Offer.create!({
                final_price: 289_000,
                buyer_confirmed: true,
                seller_confirmed: false,
                listing: Listing[2],
                user: User[1]
              })
Offer.create!({
                final_price: 384_000,
                buyer_confirmed: true,
                seller_confirmed: true,
                Listing[3],
                user: User[2]
              })
Offer.create!({
                final_price: 284_000,
                buyer_confirmed: false,
                seller_confirmed: true,
                listing: Listing[0],
                user: User[3]
              })

puts "Finished all offers"
