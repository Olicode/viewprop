class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_listing, only: %i[show edit update]

  def index
    @listings = Listing.all

    if params[:location].present?
      @listings = @listings.search_by_address(params[:location].split[0])
    end

    if params[:search] && params[:search][:address].present?
      @listings = @listings.search_by_address(params[:search][:address])
    end

    if params[:search] && params[:search][:price].present?
      @listings = @listings.where("price <= ?", params[:search][:price])
    end

    if params[:search] && params[:search][:instant_booking].present?
      @listings = @listings.search_by_instant_booking(params[:search][:instant_booking])
    end

    if params[:search] && params[:search][:negotiable].present?
      @listings = @listings.search_by_negotiable(params[:search][:negotiable])
    end

    if params[:search] && params[:search][:size].present?
      @listings = @listings.where("size <= ?", params[:search][:size])
    end

    if params[:search] && params[:search][:bedroom].present?
      @listings = @listings.where("bedroom <= ?", params[:search][:bedroom])
    end

    if params[:search] && params[:search][:bathroom].present?
      @listings = @listings.where("bathroom <= ?", params[:search][:bathroom])
    end

    @markers = @listings.geocoded.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude,
        info_window: render_to_string(partial: "info_window", locals: { listing: listing })
      }
    end
  end

  def show
    if params[:location].present?
      @listings = @listings.search_by_address(params[:location])
    end

    @markers = [
      {
        lat: @listing.latitude,
        lng: @listing.longitude
      }
    ]
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      current_user.seller = true
      redirect_to listings_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @listing.update(listing_params)
    redirect_to listing_path(@listing)
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :address, :description, :price, :negotiable, photos: [])
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
