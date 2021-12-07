class Listing < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :bookings
end
