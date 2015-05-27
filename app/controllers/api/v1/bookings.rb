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

        desc "Edit a booking"
        params do
          requires :id, type: String, desc: "Booking ID."
          group :booking, type: Hash do
            optional :doctor_id, type: Integer
            optional :slot_id, type: Integer
            optional :user_id, type: Integer
            optional :capacity_id, type: Integer
            optional :description, type: String
            optional :pain, type: Integer
            optional :booking_status_id, type: Integer
          end
        end

        put ":id", root: :booking do
          { "declared_params" => declared(params) }

          booking_params = params[:booking]

          booking = Booking.find(params[:id]);

          #Edit capacity
          if !booking_params[:capacity_id].nil? && !booking_params[:capacity_id].nil?
            booking.capacity = Capacity.find(booking_params[:capacity_id])
          end

          #Edit description
          if !booking_params[:description].nil? && !booking_params[:description].nil?
            booking.description = booking_params[:description]
          end

          #Edit pain
          if !booking_params[:pain].nil? && !booking_params[:pain].nil?
            booking.pain = booking_params[:pain]
          end

          #Edit user
          if !booking_params[:user_id].nil? && !booking_params[:user_id].nil?
            booking.user = User.find(booking_params[:user_id])
          end

          #Edit booking_status_id
          if !booking_params[:booking_status_id].nil? && !booking_params[:booking_status_id].nil?
            booking.booking_status_id = booking_params[:booking_status_id]
          end

          booking.save!()

          booking

        end
      end
    end
  end
end
