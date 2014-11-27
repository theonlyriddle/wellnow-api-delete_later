class CreateAvailabilityGenerals < ActiveRecord::Migration
  def change
    create_table :availability_generals do |t|
      t.integer :day
      t.time :hour_from
      t.time :hour_to
      t.references :doctor, index: true

      t.timestamps
    end
  end
end
