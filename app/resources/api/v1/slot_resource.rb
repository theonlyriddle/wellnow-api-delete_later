module Api
  module V1
    class SlotResource < JSONAPI::Resource
      attributes :start
      has_many :doctors
      has_many :availabilities
    end
  end
end
