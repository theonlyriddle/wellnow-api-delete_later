module Api
  module V1
    class SearchResource < JSONAPI::Resource
      #attributes :category_id, :lat, :lon, :radius, :first_doctor, :first_doctor_first_availability, :first_doctor_first_slot
      #attributes :category, :lat, :lon, :radius, :first_doctor, :first_doctor_first_availability, :first_doctor_first_slot
      attributes :lat, :lon, :radius, :first_doctor, :first_doctor_first_availability, :first_doctor_first_slot
      has_one :category
      has_many :slots
      has_many :doctors
      has_many :distances

      filter :category_id
      filter :lat
      filter :lon
      filter :radius
      filter :nb_days
    end
  end
end
