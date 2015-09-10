module Api
  module V1
    class SearchResource < JSONAPI::Resource
      #attributes :category_id, :lat, :lon, :radius, :first_doctor, :first_doctor_first_availability, :first_doctor_first_slot
      #attributes :category, :lat, :lon, :radius, :first_doctor, :first_doctor_first_availability, :first_doctor_first_slot
      #attributes :lat, :lon, :radius, :first_doctor, :first_doctor_first_availability, :first_doctor_first_slot
      attributes :lat, :lon, :radius
      has_one :category
      #has_many :distances
    end
  end
end
