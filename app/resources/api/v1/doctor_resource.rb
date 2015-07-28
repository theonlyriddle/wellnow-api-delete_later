module Api
  module V1
    class DoctorResource < JSONAPI::Resource
      attributes :firstname, :lastname, :address, :address2, :zipcode, :locality, :country_id, :latitude, :longitude, :distance, :email, :phone, :fax, :mobile, :avatar_url, :avatar_bigthumb_url, :avatar_thumb_url, :avatar_mini_url, :background_cropped_url, :background_url
      has_many :categories
    end
  end
end
