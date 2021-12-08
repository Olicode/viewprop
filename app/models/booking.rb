class Booking < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :date, :start_time, :end_time, presence: true

  STATUS = ["Accepted, Rejected", "Pending"]
end
