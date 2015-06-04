class AddEventToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :event_id, :integer
    add_foreign_key :bookings, :events
  end
end
