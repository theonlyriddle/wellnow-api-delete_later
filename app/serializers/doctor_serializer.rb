class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :address, :address2, :zipcode, :locality, :country_id, :email, :phone, :fax, :mobile, :created_at, :updated_at
end
