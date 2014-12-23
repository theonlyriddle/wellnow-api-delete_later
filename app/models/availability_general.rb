class AvailabilityGeneral < ActiveRecord::Base
    include ApplicationHelper
    
    belongs_to :doctor
    has_many :availabilities, dependent: :destroy

    validates :doctor_id, :day, :hour_from, :hour_to, presence: true
    validate :to_cannot_be_smaller_than_or_equal_to_from

    after_save :remove_all_availability_based_on_general_availability, :init_availability_based_on_general_availability

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

    #Create availability after setting general availability
    def init_availability_based_on_general_availability

        # Selects all the possible slots
        Time.zone = 'UTC'

        from = Time.zone.parse(hour_from.to_s)
        to = Time.zone.parse(hour_to.to_s)

        selected_slots = Slot.where("EXTRACT(dow FROM start) IN (#{day}) AND ((EXTRACT(hour FROM start) = #{from.hour} AND EXTRACT(minute FROM start) >= #{from.min}) OR (EXTRACT(hour FROM start) > #{from.hour} AND EXTRACT(hour FROM start) < #{to.hour}) OR (EXTRACT(hour FROM start) = #{to.hour} AND EXTRACT(minute FROM start) < #{to.min}))")

        puts "Start: #{selected_slots.first.id} - #{selected_slots.first.start}"

        inserts = []
        selected_slots.each do |s|
           inserts.push "(#{doctor_id}, #{s.id}, #{id}, now(), now())"
        end     

        sql = "INSERT INTO availabilities (\"doctor_id\", \"slot_id\", \"availability_general_id\", \"created_at\", \"updated_at\") VALUES #{inserts.join(", ")}"
        ActiveRecord::Base.connection.execute sql
        #Time.zone = 'UTC'
        puts "Hours from #{from.hour} to #{to.hour}"
    end

    def remove_all_availability_based_on_general_availability
        #availabilities.destroy()
        Availability.destroy_all(:availability_general_id => id)
    end
end
