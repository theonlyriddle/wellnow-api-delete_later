class CapacitySerializer < ActiveModel::Serializer
  attributes :id, :name, :length, :doctor_id, :created_at, :updated_at
end
