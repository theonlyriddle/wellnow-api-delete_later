class CountrySerializer < ActiveModel::Serializer
    # cached
    # delegate :cache_key, to: :object

    attributes :id, :name, :iso, :default, :default_time_zone, :created_at, :updated_at

    url :country
end
