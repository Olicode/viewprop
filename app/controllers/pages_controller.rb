class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @my_listings = Listing.where(user: current_user)
    @user = current_user
    @bookings_to_seller = Booking.joins(:listing).where(listing: { user: current_user })
    @pending_seller_bookings = @bookings_to_seller.where(status: "Pending")
    @current_seller_bookings = @bookings_to_seller.where(status: ["Accepted", "Rejected"])
    @bookings_i_made = current_user.bookings
    @seller_offers = Offer.joins(:listing).where(listing: { user: current_user })
  end
end
