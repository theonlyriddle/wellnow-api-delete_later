class Event < ActiveRecord::Base
  has_one :booking
  belongs_to :doctor
end
