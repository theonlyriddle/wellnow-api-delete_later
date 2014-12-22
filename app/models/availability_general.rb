class AvailabilityGeneral < ActiveRecord::Base
    include ApplicationHelper
    
    belongs_to :doctor
    has_many :availabilities, dependent: :destroy

    validates :doctor_id, :day, :hour_from, :hour_to, presence: true
    validate :to_cannot_be_smaller_than_or_equal_to_from

    after_create :init_availability_based_on_general_availability

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
        #inserts = []
        #Check if they are available
        #from_date = Date.today
        #to_date = Date.today + 10.days
        # (from_date..to_date).each { |d|  
        #     #Check if it's the same day
        #     if (d.wday == day)
        #         #Loop around the hours
        #         for hour in hour_from.hour..hour_to.hour
        #           [0, 15, 30, 45].each { |minutes|
        #             checked_time = Time.new(d.year, d.month, d.day, hour, minutes, 0)
        #             if ((hour < hour_to.hour || (hour == hour_to.hour && minutes < hour_to.min)) && checked_time >= Time.now)

        #                 # Later must check if there's an event here

        #                 # Add that the doctor is available if the time is between general availability dates
                        
        #                 #inserts.push "('#{checked_time}', #{doctor_id}, #{id}, #{doctor.latitude}, #{doctor.longitude}, now())"

        #               #selected_doctors.push Doctor.joins(:doctors_categories).where("category_id = ?", params[:cat]).near(lookup, radius).available_at(checked_time.wday, 0)
        #               #puts checked_time.strftime("%Y-%m-%d %H:%M")
        #             end
        #           }
        #         end
        #     end
        #   }
         # sql = "INSERT INTO availabilities (\"slot_start\", \"doctor_id\", \"availability_general_id\", \"latitude\", \"longitude\", \"created_at\") VALUES #{inserts.join(", ")}"
          #ActiveRecord::Base.connection.execute sql

        # Selects all the possible slots
        selected_slots = Slot.where("EXTRACT(dow FROM start) IN (#{day}) AND ((EXTRACT(hour FROM start) = #{hour_from.hour} AND EXTRACT(minute FROM start) >= #{hour_from.min}) OR (EXTRACT(hour FROM start) > #{hour_from.hour} AND EXTRACT(hour FROM start) < #{hour_to.hour}) OR (EXTRACT(hour FROM start) = #{hour_to.hour} AND EXTRACT(minute FROM start) < #{hour_to.min}))")

        inserts = []
        selected_slots.each do |s|
            inserts.push "(#{doctor_id}, #{s.id}, #{id}, now(), now())"
        end     

        sql = "INSERT INTO availabilities (\"doctor_id\", \"slot_id\", \"availability_general_id\", \"created_at\", \"updated_at\") VALUES #{inserts.join(", ")}"
        ActiveRecord::Base.connection.execute sql
    end
end
