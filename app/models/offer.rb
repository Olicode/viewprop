class Offer < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :final_price, presence: true
  validates :final_price, numericality: { greater_than_or_equal_to: 0 }
end
