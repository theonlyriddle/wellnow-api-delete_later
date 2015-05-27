class UserSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :address, :address2, :zipcode, :locality, :country_id, :phone, :birthdate, :created_at, :updated_at
end
