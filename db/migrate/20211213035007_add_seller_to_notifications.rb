class AddSellerToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :seller, :boolean, default: true
  end
end
