class Listing < ApplicationRecord
  belongs_to :user
  has_many :offers, destroy: :dependent
  has_many :bookings, destroy: :dependent


  validates :title, :address, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
