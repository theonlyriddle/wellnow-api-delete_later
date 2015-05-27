class CreateBookingStatuses < ActiveRecord::Migration
  def change
    create_table :booking_statuses do |t|
      t.string :name
      t.boolean :is_default, :default => false
      t.boolean :is_active, :default => false

      t.timestamps null: false
    end
  end
end
