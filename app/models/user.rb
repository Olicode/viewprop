class User < ApplicationRecord
  has_many :listings, destroy: :dependent
  has_many :offers, through: :listings

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true
end
