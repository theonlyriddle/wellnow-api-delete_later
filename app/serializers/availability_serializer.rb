class AvailabilitySerializer < ActiveModel::Serializer
  attributes :id, :doctor_id, :created_at, :updated_at, :slot_id, :doctor, :slot
  #belongs_to :doctor
  #has_many :doctors
  #has_many :categories
  #has_many :availability_generals

  #def serializable_hash
  #   doctor_serializer_hash.merge distance_serializer_hash
  #end

  # private

  # def doctor_serializer_hash
  #   DoctorSerializer.new(object, options).serializable_hash
  # end

  # def distance_serializer_hash
  #   DistanceSerializer.new(object, options).serializable_hash
  # end
end
