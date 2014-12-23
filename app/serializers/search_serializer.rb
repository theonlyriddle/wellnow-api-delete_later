class SearchSerializer < ActiveModel::Serializer
    
    attributes :category_id, :lat, :lon, :radius, :doctors
    has_many :slots
end
