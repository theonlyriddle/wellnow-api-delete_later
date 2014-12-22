class AddAvailabilityGeneralToAvailability < ActiveRecord::Migration
  def change
    add_reference :availabilities, :availability_general, index: true
  end
end
