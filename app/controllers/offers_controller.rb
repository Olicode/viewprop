class OffersController < ApplicationController

  def index
    @offer = current_user.offers
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

end
