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

LOCATION = ["Ubud", "Canggu", "Uluwatu", "Semiyak", "Denpasar", "Jembrana", "Singaraja"]
VERB = ["great", "nice", "secluded", "quiet", "green", "marvelous"]
SPOT = ["area", "location"]
PHRASE = ["huge opportunity!", "development opportunity!", "with amazing ocean view!", "luxury Penthouse!", "beautifull Villa"]
PRICE = [45_000, 75_000, 110_000, 144_000, 178_000, 220_000, 267_000, 290_000, 320_000, 362_000, 490_000]
NEGOTIABLE = [true, false]
INSTANT = [true, false]
USER = [User.first, User.second, User.third, User.fourth]
SIZE = [44, 56, 76, 90, 112, 126, 144, 167]
BEDROOM = [1, 2, 3, 4]
BATHROOM = [1, 2, 3, 4]

30.times do
  x = LOCATION.sample
  y = VERB.sample
  z = SPOT.sample
  t = PHRASE.sample
  Listing.create({
                    title: "#{x} #{y} #{z}, #{t}",
                    address: "#{x}, Bali",
                    description: "#{BEDROOM.sample} BR luxury villa",
                    price: PRICE.sample,
                    negotiable: NEGOTIABLE.sample,
                    instant_booking: INSTANT.sample,
                    user: USER.sample,
                    size: SIZE.sample,
                    bedroom: BEDROOM.sample,
                    bathroom: BATHROOM.sample
                  })
end

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

puts "Finished all offers"
