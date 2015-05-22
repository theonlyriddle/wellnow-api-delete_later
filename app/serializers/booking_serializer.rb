class BookingSerializer < ActiveModel::Serializer
  attributes :id, :doctor_id, :slot_id, :user_id, :capacity_id, :description, :pain, :booking_status_id, :created_at, :updated_at
end
