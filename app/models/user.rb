class User < ApplicationRecord
  has_many :listings, dependent: :destroy
  has_many :offers, through: :listings
  has_many :bookings, through: :listings

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true
end
