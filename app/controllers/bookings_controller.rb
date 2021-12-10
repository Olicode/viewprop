class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @listing = Listing.find(params[:listing_id])
    @booking.listing = @listing
    @booking.user = current_user
    if @booking.save
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def delete
    @booking = Booking.find(params[:id])
    @booking.destroy!
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(status_params)
    redirect_to dashboard_path
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :start_time, :end_time)
  end

  def status_params
    params.require(:booking).permit(:status)
  end
end
