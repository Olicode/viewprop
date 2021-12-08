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
      redirect_to dashboard
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @offer = Offer.find(params[:id])
    @listing = Listing.find(params[:listing_id])
    if @offer.listing.user == current_user
      @offer.buyer_confirmed = false
      @offer.seller_confirmed = true
    elsif @offer.user == current_user
      @offer.buyer_confirmed = true
      @offer.seller_confirmed = false
    end
    if @offer.update(offer_params)
      redirect_to dashboard
    else
      render 'edit'
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:final_price)
  end
end
