class SlotSerializer < ActiveModel::Serializer
  #attributes :id, :firstname, :lastname, :address, :address2, :zipcode, :locality, :country_id, :latitude, :longitude, :email, :phone, :fax, :mobile, :avatar_url, :avatar_bigthumb_url, :avatar_thumb_url, :avatar_mini_url, :background_cropped_url, :background_url, :category_ids, :created_at, :updated_at, :category_ids
  attributes :id, :start, :doctors
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
