class Listing < ApplicationRecord
  belongs_to :user
  has_many :offers, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  has_one_attached :audio

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :title, :address, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  after_create :update_user_to_seller

  include PgSearch::Model
  pg_search_scope :search_by_address,
                  against: :address,
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_price,
                  against: :price,
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_instant_booking,
                  against: :instant_booking,
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_negotiable,
                  against: :negotiable,
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_size,
                  against: :size,
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_bedroom,
                  against: :bedroom,
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_bathroom,
                  against: :bathroom,
                  using: {
                    tsearch: { prefix: true }
                  }

  def update_user_to_seller
    user.update(seller: true)
  end
end
