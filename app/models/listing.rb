class Listing < ApplicationRecord
  belongs_to :user
  has_many :offers, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :title, :address, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

end
