class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.datetime :start

      t.timestamps
    end

    add_reference :availabilities, :slot, index: true

    remove_column :availabilities, :slot_start
  end
end
