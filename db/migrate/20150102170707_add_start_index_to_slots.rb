class AddStartIndexToSlots < ActiveRecord::Migration
  def change
    add_index :slots, :start
  end
end
