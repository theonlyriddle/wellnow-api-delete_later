class AvailabilityGeneral < ActiveRecord::Base
    include ApplicationHelper
    
    belongs_to :doctor

    validates :doctor_id, :day, :hour_from, :hour_to, presence: true
    validate :to_cannot_be_smaller_than_or_equal_to_from

    def to_s
        doctor.full_name + ", " + day.to_s + "(" + hour_from.to_s + "-" + hour_to.to_s + ")"
    end

    def day_name
        name_of_the_day(day)
    end

    def hour_from_formatted
        hour_from.strftime "%H:%M"
    end

    def hour_to_formatted
        hour_to.strftime "%H:%M"
    end

    #Validators
    def to_cannot_be_smaller_than_or_equal_to_from
        if hour_to <= hour_from
          errors.add(:hour_to, "can't be smaller than or equal to Hour from")
        end
    end
end
