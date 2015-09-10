class Search < ActiveRecord::Base
    belongs_to :category
    has_many :distances
    has_many :doctors, through: :distances
    #has_many :slots

    # def doctors=(docs)
    #     @doctors = docs
    # end
    #
    # def doctors
    #     @doctors
    # end

    # def first_doctor
    #     @doctors.first unless @doctors.blank?
    # end
    #
    # def slots=(slots)
    #     @slots = slots
    # end
    #
    # def slots
    #     @slots
    # end
    #
    # def first_doctor_first_availability
    #     Availability.joins(:slot).where('start > (?) AND doctor_id = (?)', Time.zone.now + 1.hours, first_doctor.id).order('start').first unless @doctors.blank?
    # end
    #
    # def first_doctor_first_slot
    #     Slot.find(first_doctor_first_availability.slot_id) unless @doctors.blank?
    # end
end
