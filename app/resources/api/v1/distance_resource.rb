module Api
  module V1
    class DistanceResource < JSONAPI::Resource
      attributes :calculated_distance
      has_one :search
      has_one :doctor
    end
  end
end
