class Offer < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :final_price, presence: true
  validates :final_price, numericality: { greater_than_or_equal_to: 0 }
  validate :cannot_make_offer_on_own_listing, :two_offers_on_listing

  def cannot_make_offer_on_own_listing
    if user == listing.user
      errors.add(:user, "You cannot place an offer on your own listing")
    end
  end

  def two_offers_on_listing
    if listing.offers.where.not(buyer_confirmation: false, seller_confirmation: false).pluck(:user_id).include?(user_id)
      errors.add(:user, "You cannot place two offers on the same listing")
    end
  end
end
