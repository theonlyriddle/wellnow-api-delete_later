class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name, :iso, :rank, :created_at, :updated_at
end
