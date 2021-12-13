class Notification < ApplicationRecord
  belongs_to :booking, optional: true
  belongs_to :offer, optional: true
  belongs_to :user
end
