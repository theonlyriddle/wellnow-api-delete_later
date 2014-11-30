class AddIndexToDoctor < ActiveRecord::Migration
  def change
    add_index :doctors, [:latitude, :longitude]
  end
end
