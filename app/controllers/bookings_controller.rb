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
      Notification.create(user: @listing.user, booking: @booking, content: "You have a new booking for #{@listing.title}", seller: true)
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def delete
    @booking = Booking.find(params[:id])
    Notification.create(user: current_user, booking: @booking, content: "You cancelled a viewing for #{@booking.listing.title}", seller: false)
    Notification.create(user: @booking.listing.user, booking: @booking, content: "#{@booking.user.first_name} has just cancelled a viewing for #{@booking.listing.title}", seller: true)
    @booking.destroy!
  end

  def update
    @booking = Booking.find(params[:id])
    Notification.create(user: current_user, booking: @booking, content: "You have updated the booking for #{@booking.listing.title}", seller: false)
    Notification.create(user: @booking.listing.user, booking: @booking, content: "#{@booking.listing.title} booking has been updated", seller: true)
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
