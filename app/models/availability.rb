class Availability < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :availability_general
end
