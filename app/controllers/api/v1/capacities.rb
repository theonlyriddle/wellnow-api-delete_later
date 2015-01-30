module API
  module V1
    class Capacities < Grape::API
      include API::V1::Defaults

      resource :capacities do

        desc "Return all availabilities"
        params do
          optional :doctor_id, type: Integer
        end

        get "", root: :availabilities do
          if !params[:doctor_id].nil?
            Capacity.where("doctor_id" => params[:doctor_id])
          else
            Capacity.all
          end
        end

        desc "Return an availability"
        params do
          requires :id, type: String, desc: "ID of the availability"
        end
        get ":id", root: "availability", serializer: AvailabilitySerializer do
          Availability.find(params[:id])
        end
      end
    end
  end
end