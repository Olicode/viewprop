class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @my_listings = Listing.where(user: current_user)
    @bookings_to_seller = Booking.joins(:listing).where(listing: { user: current_user })
    @pending_seller_bookings = @bookings_to_seller.where(status: "Pending")
    @current_seller_bookings = @bookings_to_seller.where(status: ["Accepted", "Rejected"])
    @seller_offers = Offer.joins(:listing).where(listing: { user: current_user })
    @pending_seller_offers = @seller_offers.where(buyer_confirmed: true, seller_confirmed: false).or(@seller_offers.where(buyer_confirmed: false, seller_confirmed: true))
    @accepted_seller_offers = @seller_offers.where(buyer_confirmed: true, seller_confirmed: true)
    @rejected_seller_offers = @seller_offers.where(buyer_confirmed: false, seller_confirmed: false)
    @bookings_i_made = current_user.bookings
  end

  def history
    @seller_offers = Offer.joins(:listing).where(listing: { user: current_user })
    @accepted_seller_offers = @seller_offers.where(buyer_confirmed: true, seller_confirmed: true)
    @rejected_seller_offers = @seller_offers.where(buyer_confirmed: false, seller_confirmed: false)
  end
end
