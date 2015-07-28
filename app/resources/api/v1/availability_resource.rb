module Api
  module V1
    class AvailabilityResource < JSONAPI::Resource
      attributes :doctor_id, :slot_id, :created_at, :updated_at
      has_one :doctor
      has_one :slot
    end
  end
end
