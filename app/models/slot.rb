class Slot < ActiveRecord::Base
    has_many :availabilities
    has_many :doctors, through: :availabilities
end
