class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :address, :address2, :zipcode, :locality, :country_id, :latitude, :longitude, :email, :phone, :fax, :mobile, :avatar_url, :avatar_bigthumb_url, :avatar_thumb_url, :avatar_mini_url, :background_cropped_url, :background_url, :category_ids, :created_at, :updated_at, :category_ids
  has_many :categories
  has_many :availability_generals
end
