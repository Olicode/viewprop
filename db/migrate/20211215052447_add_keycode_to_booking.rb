class AddKeycodeToBooking < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :keycode, :string
  end
end
