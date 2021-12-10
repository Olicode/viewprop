class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :date, :start_time, :end_time, presence: true
  validate :end_time_cannot_be_less_than_start_time, :different_owner, :no_booking_same_day, :no_booking_on_sold_listing, on: :create

  STATUS = ["Accepted", "Rejected", "Pending"]

  def end_time_cannot_be_less_than_start_time
    return unless start_time && end_time
    if end_time < start_time
      errors.add(:end_time, "has to be after the starting time")
    end
  end

  def different_owner
    if listing.user == user
      errors.add(:user, "You cannot book to view your own listing")
    end
  end

  def no_booking_same_day
    if !listing.bookings.where(user: self.user, date: self.date).empty?
      errors.add(:date, "You cannot book two viewings on the same day")
    end
  end

  def no_booking_on_sold_listing
    if listing.sold
      errors.add(:user, "You cannot book to view this listing")
    end
  end
end
