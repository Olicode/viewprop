class Offer < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :final_price, presence: true
  validates :final_price, numericality: { greater_than_or_equal_to: 0 }
  validate :cannot_make_offer_on_own_listing, :two_offers_on_listing, :no_offer_on_sold_listing, on: :create
  validate :no_offer_on_non_negotiable, if: :will_save_change_to_final_price?


  def cannot_make_offer_on_own_listing
    if user == listing.user
      errors.add(:final_price, "| You cannot place an offer on your own listing")
    end
  end

  def two_offers_on_listing
    if listing.offers.where.not(buyer_confirmed: false, seller_confirmed: false).pluck(:user_id).include?(user_id)
      errors.add(:final_price, "| You cannot place two offers on the same listing")
    end
  end

  def no_offer_on_sold_listing
    if listing.sold
      errors.add(:final_price, "| You cannot make an offer for this listing")
    end
  end

  def no_offer_on_non_negotiable
    if listing.negotiable == false && listing.price != final_price
      errors.add(:final_price, " | You cannot change the nominal for a non-negotiable listing")
    end
  end

end
