class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @listing = Listing.find(params[:listing_id])
    if @listing.instant_booking
      @booking.status = "Accepted"
    end
    @booking.listing = @listing
    @booking.user = current_user
    @booking.keycode = keycode
    if @booking.save
      Notification.create(user: @listing.user, booking: @booking, content: "You have a new booking for #{@listing.title}", seller: true)
      Notification.create(user: current_user, booking: @booking, content: "You have just made a booking for #{@listing.title.truncate(10)}. You will receive an encrypted keycode through booking details.", seller: false)
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @listing = @booking.listing
    @conversation = current_user.conversation_with(@listing.user)
    if !@conversation
      @conversation = Conversation.new(sender_id: current_user.id, receiver_id: @listing.user.id)
      @conversation.save!
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

  def keycode
    first_number = rand(0..9)
    second_number = rand(0..9)
    third_letter = %i[a b c d e f g h i j k l m n o p q r s t u v w x y z].sample
    fourth_letter = %i[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z].sample
    fifth_number = rand(0..9)
    sixth_letter = %i[a b c d e f g h i j k l m n o p q r s t u v w x y z].sample
    return "#{first_number}#{second_number}#{third_letter}#{fourth_letter}#{fifth_number}#{sixth_letter}"
  end
end
