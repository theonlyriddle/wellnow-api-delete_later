module API
  module V1
    class Bookings < Grape::API
      include API::V1::Defaults

      resource :bookings do

        desc "Return all bookings"
        get "", root: :bookings do
          Booking.all
        end

        desc "Return a booking"
        params do
          requires :id, type: Integer, desc: "ID of the booking"
        end
        get ":id", root: "booking" do
          Booking.where(id: permitted_params[:id]).first!
        end

        desc "Create a booking"
        params do
          group :booking, type: Hash do
            requires :doctor_id, type: Integer
            requires :slot_id, type: Integer
            optional :user_id, type: Integer
            optional :description, type: String
            optional :pain, type: Integer
          end
        end

        post "", root: :booking do
          { "declared_params" => declared(params) }

          booking_params = params[:booking]

          booking = Booking.create!(
            :doctor_id => booking_params['doctor_id'],
            :slot_id => booking_params['slot_id'],
            :user_id => booking_params['user_id'],
            :description => booking_params['description'],
            :pain => booking_params['pain']
          )

          booking

        end
      end
    end
  end
end
