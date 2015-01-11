class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :doctor
  belongs_to :slot
  belongs_to :capacity
end
