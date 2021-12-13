class User < ApplicationRecord
  has_many :listings, dependent: :destroy
  has_many :offers
  has_many :bookings, through: :listings
  has_one_attached :avatar
  has_many :notifications

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  def conversations
    Conversation.where(sender_id: id).or(Conversation.where(receiver_id: id))
  end
end
