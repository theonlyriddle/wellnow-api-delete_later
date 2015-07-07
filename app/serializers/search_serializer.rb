class SearchSerializer < ActiveModel::Serializer

    attributes :id, :category_id, :lat, :lon, :radius, :doctors, :first_doctor, :first_doctor_first_availability, :first_doctor_first_slot
    has_many :slots
end
