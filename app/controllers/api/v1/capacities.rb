module API
  module V1
    class Capacities < Grape::API
      include API::V1::Defaults

      resource :capacities do

        desc "Return all capacities"
        params do
          optional :doctor_id, type: Integer
        end

        get "", root: :capacities do
          if !params[:doctor_id].nil?
            Capacity.where("doctor_id" => params[:doctor_id])
          else
            Capacity.all
          end
        end

        desc "Return a capacity"
        params do
          requires :id, type: String, desc: "ID of the capacity"
        end
        get ":id", root: "availability", serializer: CapacitySerializer do
          Capacity.find(params[:id])
        end
      end
    end
  end
end
