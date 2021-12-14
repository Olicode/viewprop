class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @listings = Listing.where(instant_booking: true).first(6)
  end

  def dashboard
    # seller dashboard
    @my_listings = Listing.where(user: current_user)
    @bookings_to_seller = Booking.joins(:listing).where(listing: { user: current_user })
    @pending_seller_bookings = @bookings_to_seller.where(status: "Pending")
    @current_seller_bookings = @bookings_to_seller.where(status: ["Accepted", "Rejected"])
    @seller_offers = Offer.joins(:listing).where(listing: { user: current_user })
    @waiting_seller_offers = @seller_offers.where(buyer_confirmed: false, seller_confirmed: true)
    @pending_seller_offers = @seller_offers.where(buyer_confirmed: true, seller_confirmed: false)
    @accepted_seller_offers = @seller_offers.where(buyer_confirmed: true, seller_confirmed: true)
    @rejected_seller_offers = @seller_offers.where(buyer_confirmed: false, seller_confirmed: false)
    # buyer dashboard
    @bookings_i_made = current_user.bookings
    @pending_buyer_bookings = @bookings_i_made.where(status: "Pending")
    @current_buyer_bookings = @bookings_i_made.where(status: ["Accepted", "Rejected"])
    @offers_buyer = current_user.offers
    @waiting_buyer_offers = @offers_buyer.where(buyer_confirmed: true, seller_confirmed: false)
    @pending_buyer_offers = @offers_buyer.where(buyer_confirmed: false, seller_confirmed: true)
    @accepted_buyer_offers = @offers_buyer.where(buyer_confirmed: true, seller_confirmed: true)
    @rejected_buyer_offers = @offers_buyer.where(buyer_confirmed: false, seller_confirmed: false)
    @listings_searched = session[:listing_id].map { |id| Listing.find(id) }
    # seller notifications
    @seller_notifications = current_user.notifications.where(seller: true)
    # buyer notifications
    @buyer_notifications = current_user.notifications.where(seller: false)
  end

  def history
    # listings sold - offers
    @seller_offers = Offer.joins(:listing).where(listing: { user: current_user, sold: true })
    @accepted_seller_offers = @seller_offers.where(buyer_confirmed: true, seller_confirmed: true)
    @rejected_seller_offers = @seller_offers.where(buyer_confirmed: false, seller_confirmed: false)
    # listings bought - offers
    @buyer_offers = current_user.offers
    @accepted_buyer_offers = @buyer_offers.joins(:listing).where(listings: { sold: true })
  end
end
