class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true
      t.references :doctor, index: true
      t.references :slot, index: true
      t.references :capacity, index: true
      t.text :description
      t.integer :pain

      t.timestamps null: false
    end
    add_foreign_key :bookings, :users
    add_foreign_key :bookings, :doctors
    add_foreign_key :bookings, :slots
    add_foreign_key :bookings, :capacities
  end
end
