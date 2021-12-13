class OffersController < ApplicationController
  def new
    @offer = Offer.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @offer = Offer.new(offer_params)
    @listing = Listing.find(params[:listing_id])
    @offer.listing = @listing
    @offer.user = current_user
    @offer.buyer_confirmed = true
    if @offer.save
      Notification.create(user: @listing.user, offer: @offer, content: "You have a new offer for #{@listing.title}", seller: true)
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def edit
    @offer = Offer.find(params[:id])
    @listing = @offer.listing
  end

  def update
    @offer = Offer.find(params[:id])
    @listing = @offer.listing

    if params[:accept].present?
      @offer.buyer_confirmed = true
      @offer.seller_confirmed = true
      Notification.create(user: @offer.listing.user, offer: @offer, content: "Offer for #{@listing.title} has been accepted. Please proceed to payment.", seller: false)
      Notification.create(user: @offer.user, offer: @offer, content: "Offer for #{@listing.title} has been accepted. Please wait for payment.", seller: true)
    elsif @offer.listing.user == current_user
      @offer.buyer_confirmed = false
      @offer.seller_confirmed = true
      Notification.create(user: @offer.user, offer: @offer, content: "There is a counter offer for #{@offer.listing.title}", seller: false)
      @offer.update(offer_params)
    elsif @offer.user == current_user
      @offer.buyer_confirmed = true
      @offer.seller_confirmed = false
      Notification.create(user: @offer.listing.user, offer: @offer, content: "There is a counter ofer for #{@offer.listing.title}", seller: true)
      @offer.update(offer_params)
    end

    if @offer.save
      redirect_to dashboard_path
    else
      render 'edit'
    end
  end

  # def accept
  #   @offer = Offer.find(params)
  # end

  private

  def offer_params
    params.require(:offer).permit(:final_price)
  end
end
