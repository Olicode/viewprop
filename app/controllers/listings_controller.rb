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
      if params[:search][:price] == "< 70.000"
        @listings = @listings.where("price < ?", 70000)
      elsif params[:search][:price] == "70.000 - 150.000"
        @listings = @listings.where("price < ? AND price > ?", 150000, 70000)
      elsif params[:search][:price] == "150.000 - 250.000"
        @listings = @listings.where("price < ? AND price > ?", 250000, 150000)
      elsif params[:search][:price] == "250.000 - 450.000"
        @listings = @listings.where("price < ? AND price > ?", 450000, 250000)
      elsif params[:search][:price] == "450.000 +"
        @listings = @listings.where("price > ?", 450000)
      end
    end

    if params[:search] && params[:search][:instant_booking].present?
      instant_booking = params[:search][:instant_booking] == "1"
      @listings = @listings.search_by_instant_booking(instant_booking)
    end

    if params[:search] && params[:search][:negotiable].present?
      negotiable = params[:search][:negotiable] == "1"
      @listings = @listings.search_by_negotiable(negotiable)
    end

    if params[:search] && params[:search][:size].present?
      if params[:search][:size] == "< 50"
        @listings = @listings.where("size < ?", 50)
      elsif params[:search][:size] == "50 - 100"
        @listings = @listings.where("size < ? AND size > ?", 100, 50)
      elsif params[:search][:size] == "> 100"
        @listings = @listings.where("size > ?", 100)
      end
    end

    if params[:search] && params[:search][:bedroom].present?
      @listings = @listings.where("bedroom = ?", params[:search][:bedroom].to_i)
    end

    if params[:search] && params[:search][:bathroom].present?
      @listings = @listings.where("bathroom = ?", params[:search][:bathroom])
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
    current_user.update(seller: true)
    if @listing.save
      redirect_to listing_path(@listing)
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
    params.require(:listing).permit(:title, :address, :description, :price, :negotiable, :size, :bedroom, :bathroom, :security_package, photos: [])
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
