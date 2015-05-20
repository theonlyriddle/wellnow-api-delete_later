class AddStatusToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :booking_status_id, :integer, :default => 1
    add_foreign_key :bookings, :booking_statuses
  end
end
