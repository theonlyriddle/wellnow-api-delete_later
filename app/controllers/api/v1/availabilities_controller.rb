module Api
  module V1
    class AvailabilitiesController < JSONAPI::ResourceController
      # include API::V1::Defaults
      #
      # resource :availabilities do
      #
      #   desc "Return all availabilities"
      #   params do
      #     optional :doctor_id, type: Integer
      #     optional :slot_id, type: Integer
      #   end
      #
      #   get "", root: :availabilities do
      #     if !params[:doctor_id].nil? && !params[:slot_id].nil?
      #       Availability.where("doctor_id" => params[:doctor_id], "slot_id" => params[:slot_id])
      #     else
      #       Availability.all
      #     end
      #   end
      #
      #   desc "Return an availability"
      #   params do
      #     requires :id, type: String, desc: "ID of the availability"
      #   end
      #   get ":id", root: "availability", serializer: AvailabilitySerializer do
      #     Availability.find(params[:id])
      #   end
      # end
    end
  end
end
