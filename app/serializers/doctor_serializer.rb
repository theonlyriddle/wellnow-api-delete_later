class DoctorSerializer < ActiveModel::Serializer
    cached
    delegate :cache_key, to: :object
    
    attributes :id, :firstname, :lastname, :address, :address2, :zipcode, :locality, :country_id, :latitude, :longitude, :email, :phone, :fax, :mobile, :avatar_url, :avatar_bigthumb_url, :avatar_thumb_url, :avatar_mini_url, :background_cropped_url, :background_url, :created_at, :updated_at, :categories
    #attributes :id, :firstname, :my_distance
    #attributes :distance, :bearing
    #has_many :categories
    #has_many :availability_generals
end
