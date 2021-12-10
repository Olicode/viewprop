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
                  user: User.first,
                  size: 113,
                  bedroom: 3,
                  bathroom: 2
                })

Listing.create!({
                  title: "Ubud quiet location, huge opportunity!",
                  address: "Ubud, Bali",
                  description: "3 BR luxury villa",
                  price: 299.000,
                  negotiable: false,
                  instant_booking: true,
                  user: User.second,
                  size: 110,
                  bedroom: 3,
                  bathroom: 3
                })

Listing.create!({
                  title: "Canggu quiet location, development opportunity!",
                  address: "Canggu, Bali",
                  description: "4 BR villa",
                  price: 180.000,
                  negotiable: false,
                  instant_booking: true,
                  user: User.third,
                  size: 130,
                  bedroom: 4,
                  bathroom: 2
                })

Listing.create!({
                  title: "Uluwatu quiet location, ocean view petite apt!",
                  address: "Uluwatu, Bali",
                  description: "1 BR luxury apt",
                  price: 280.000,
                  negotiable: false,
                  instant_booking: false,
                  user: User.fourth,
                  size: 44,
                  bedroom: 1,
                  bathroom: 1
                })

Listing.create!({
                  title: "Ubud prime location, huge opportunity!",
                  address: "Ubud, Bali",
                  description: "2 BR villa",
                  price: 269.000,
                  negotiable: true,
                  instant_booking: true,
                  user: User.first,
                  size: 70,
                  bedroom: 2,
                  bathroom: 2
                })

Listing.create!({
                  title: "Ubud, secluded green gem!",
                  address: "Ubud, Bali",
                  description: "3 BR luxury villa",
                  price: 323.000,
                  negotiable: true,
                  instant_booking: false,
                  user: User.second,
                  size: 120,
                  bedroom: 3,
                  bathroom: 3
                })

Listing.create!({
                  title: "Denpasar, close to International Airport!",
                  address: "Denpasar, Bali",
                  description: "2 BR apartment",
                  price: 156.000,
                  negotiable: true,
                  instant_booking: false,
                  user: User.third,
                  size: 62,
                  bedroom: 2,
                  bathroom: 1
                })

Listing.create!({
                  title: "Uluwatu quiet location, ocean view luxury Penthouse!",
                  address: "Uluwatu, Bali",
                  description: "3 BR penthouse",
                  price: 396.000,
                  negotiable: true,
                  instant_booking: false,
                  user: User.fourth,
                  size: 132,
                  bedroom: 3,
                  bathroom: 3
                })

puts "Finished creating listings!"

puts "Create bookings"

Booking.create!({
                  date: "12-04-2021",
                  start_time: "9:30",
                  end_time: "10:00",
                  status: "Accepted",
                  listing: Listing.third,
                  user: User.first
                })
Booking.create!({
                  date: "12-12-2021",
                  start_time: "10:30",
                  end_time: "11:00",
                  status: "Pending",
                  listing: Listing.first,
                  user: User.second
                })
Booking.create!({
                  date: "14-07-2021",
                  start_time: "7:30",
                  end_time: "08:00",
                  status: "Rejected",
                  listing: Listing.second,
                  user: User.third
                })
Booking.create!({
                  date: "12-12-2021",
                  start_time: "13:30",
                  end_time: "14:00",
                  status: "Accepted",
                  listing: Listing.third,
                  user: User.fourth
                })

puts "Finish creating Bookings"

puts "Creating offers"

Offer.create!({
                final_price: 139_000,
                buyer_confirmed: true,
                seller_confirmed: false,
                listing: Listing.third,
                user: User.first
              })
Offer.create!({
                final_price: 289_000,
                buyer_confirmed: true,
                seller_confirmed: false,
                listing: Listing.second,
                user: User.first
              })
Offer.create!({
                final_price: 384_000,
                buyer_confirmed: true,
                seller_confirmed: true,
                listing: Listing.third,
                user: User.second
              })
Offer.create!({
                final_price: 284_000,
                buyer_confirmed: false,
                seller_confirmed: true,
                listing: Listing.first,
                user: User.third
              })

puts "Finished all offers"
