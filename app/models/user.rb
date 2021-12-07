class User < ApplicationRecord
  has_many :listings
  has_many :offers, through: :listings

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
