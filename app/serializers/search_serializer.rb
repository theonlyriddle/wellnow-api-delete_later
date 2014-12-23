class SearchSerializer < ActiveModel::Serializer
    
    attributes :lat, :lon
    #attributes :id, :firstname, :my_distance
    #attributes :distance, :bearing
    #has_many :categories
    #has_many :availability_generals
end
