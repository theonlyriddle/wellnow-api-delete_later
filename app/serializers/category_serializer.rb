class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :rank, :created_at, :updated_at
end
