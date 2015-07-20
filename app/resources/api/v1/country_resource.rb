module Api
  module V1
    class CountryResource < JSONAPI::Resource
      attributes :name, :iso, :default
    end
  end
end
