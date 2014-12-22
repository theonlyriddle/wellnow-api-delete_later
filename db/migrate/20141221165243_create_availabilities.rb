class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.datetime :slot_start
      t.references :doctor, index: true

      t.timestamps
    end
  end
end
