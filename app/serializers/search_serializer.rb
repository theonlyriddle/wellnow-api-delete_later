class SearchSerializer < ActiveModel::Serializer
    
    attributes :lat, :lon, :radius, :doctors
    has_many :slots
end
