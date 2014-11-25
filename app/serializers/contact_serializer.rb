class ContactSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :title, :language, :created_at, :updated_at
end
