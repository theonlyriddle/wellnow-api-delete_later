class CategorySerializer < ActiveModel::Serializer
    # cached
    # delegate :cache_key, to: :object

    attributes :id, :title, :description, :rank, :created_at, :updated_at
end
