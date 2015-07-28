module Api
  module V1
    class SlotsController < JSONAPI::ResourceController
      # include API::V1::Defaults
      #
      # resource :slots do
      #
      #   desc "Return all slots"
      #   params do
      #     requires :cat, type: Integer
      #     optional :lat, type: Float
      #     optional :lon, type: Float
      #     optional :addr, type: String
      #     optional :radius, type: Float
      #     optional :nb_days, type: Integer
      #     optional :latestslotdate, type: String
      #   end
      #   get "", root: :slots do
      #     { "declared_params" => declared(params) }
      #
      #     search_params = params
      #
      #     #Nb of days you want to search
      #     nb_days = search_params[:nb_days] || Settings.search.default_nb_days
      #
      #     #Search by latitude and longitude or address
      #     if !search_params[:lat].nil? && !search_params[:lon].nil?
      #       lookup = [search_params[:lat], search_params[:lon]]
      #     else
      #       lookup = search_params[:addr]
      #     end
      #
      #     #Radius
      #     radius = search_params[:radius] || Settings.search.default_radius
      #
      #     #Paging
      #     if search_params[:latestslotdate].nil?
      #       offset_days = nb_days
      #
      #     else
      #       offset_days = ((Time.zone.parse(search_params[:latestslotdate]).to_date - Time.zone.now.to_date).to_i + 1)
      #     end
      #
      #     time_start = Time.zone.now.midnight
      #
      #     doctors = Doctor.joins(:categories).where("category_id = ?", params[:cat]).near(lookup, radius)
      #
      #     #Find available slots in a week
      #     begin
      #       slots = Slot.includes(:availabilities, :doctors).joins(:availabilities, :doctors).where("start > (?) AND start <= (?)", (time_start + offset_days.days), Date.today + offset_days.days + nb_days.days).order(:start).merge(doctors)
      #       offset_days += 1
      #     end until !slots.blank? || offset_days > 7
      #
      #     slots
      #   end
      #
      #   desc "Return a slot"
      #   params do
      #     requires :id, type: String, desc: "ID of the slot"
      #   end
      #   get ":id", root: "slot", serializer: SlotSerializer do
      #     Slot.where(id: permitted_params[:id]).first!
      #   end
      # end
    end
  end
end
