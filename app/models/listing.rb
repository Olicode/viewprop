class Listing < ApplicationRecord
  belongs_to :user
  has_many :offers, dependent: :destroy
  has_many :bookings, dependent: :destroy


  validates :title, :address, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
