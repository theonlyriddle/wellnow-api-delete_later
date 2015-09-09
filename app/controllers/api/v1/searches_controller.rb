module Api
  module V1
    class SearchesController < JSONAPI::ResourceController

      respond_to :json

      # def index
      #   searches = Search.last(3)
      #   include_resources = ['doctors']
      #   searches_json = JSONAPI::ResourceSerializer.new(SearchResource, include: include_resources).serialize_to_hash(SearchResource.new(searches))
      #   render json: searches_json
      # end

      def show
        search = Search.find(params[:id])

        lookup = [search.lat, search.lon]
        radius = search.radius || Settings.search.default_radius

        search.doctors = Doctor.joins(:categories).where("category_id = ?", search.category_id).near(lookup, radius)

        distances = []
        search.doctors.each do |doc|
          puts doc.distance
          distances << Distance.new(:calculated_distance => doc.distance, :search_id => search.id, :doctor_id => doc.id)
        end
        Distance.import distances

        #Nb of days you want to search
        nb_days = params[:nb_days] || Settings.search.default_nb_days

        #Paging
        offset_days = 0
        time_start = Time.zone.now + 1.hours

        #Find available slots in a week
        begin
          search.slots = Slot.includes(:availabilities, :doctors).joins(:availabilities, :doctors).where("start > (?) AND start <= (?)", (time_start + offset_days.days), Date.today + offset_days.days + nb_days.days).order(:start).merge(search.doctors)
          offset_days += 1
        end until !search.slots.blank? || offset_days > 7

        search_json = JSONAPI::ResourceSerializer.new(SearchResource, include: ['doctors', 'slots', 'distances']).serialize_to_hash(SearchResource.new(search))
        render json: search_json
      end

      def create

        sparams = params[:data][:attributes]
        category = params[:data][:relationships][:category][:data][:id]



        #Nb of days you want to search
        nb_days = sparams[:nb_days] || Settings.search.default_nb_days

        #Search by latitude and longitude or address
        if !sparams[:lat].nil? && !sparams[:lon].nil?
          lookup = [sparams[:lat], sparams[:lon]]
        else
          lookup = sparams[:addr]
        end

        #Radius
        radius = sparams[:radius] || Settings.search.default_radius

        search = Search.create!(:category_id => category, :lat => sparams['lat'], :lon => sparams['lon'], :radius => radius)
        #
        # search.doctors = []
        # search.slots = []

        search_json = JSONAPI::ResourceSerializer.new(SearchResource).serialize_to_hash(SearchResource.new(search))
        render json: search_json
      end

      private

      def search_params
        params.permit(:data, :category, :lat, :lon, :nb_days, :radius, :address)
      end

      # def search_params
      #   params.require(:search).permit(:email, :password)
      # end

      # include API::V1::Defaults
      #
      # resource :search do
      #   desc "Create a search"
      #   params do
      #     group :search, type: Hash do
      #       requires :cat, type: Integer
      #       optional :lat, type: Float
      #       optional :lon, type: Float
      #       optional :addr, type: String
      #       optional :radius, type: Float
      #       optional :nb_days, type: Integer
      #     end
      #   end
      #
      #   post "", root: :search do
      #     { "declared_params" => declared(params) }
      #
      #     search_params = params[:search]
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
      #     search = Search.create!(:category_id => search_params['cat'], :lat => search_params['lat'], :lon => search_params['lon'], :radius => radius)
      #
      #     search.doctors = []
      #     search.slots = []
      #
      #     search
      #
      #   end
      #
      #   desc "Search for doctors"
      #   params do
      #     requires :cat, type: Integer
      #     optional :lat, type: Float
      #     optional :lon, type: Float
      #     optional :addr, type: String
      #     optional :radius, type: Float
      #     optional :nb_days, type: Integer
      #   end
      #
      #   get "", root: :searches, each_serializer: SearchSerializer do
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
      #     offset_days = 0
      #     time_start = Time.zone.now + 1.hours
      #
      #     search = Search.where(:category_id => search_params['cat'], :lat => search_params['lat'], :lon => search_params['lon'], :radius => radius).last
      #
      #     # search = Search.last
      #
      #     #Search all doctors in the selected area, ordered by distance
      #     search.doctors = Doctor.joins(:categories).where("category_id = ?", search.category_id).near(lookup, radius)
      #
      #     #Find available slots in a week
      #     begin
      #       search.slots = Slot.includes(:availabilities, :doctors).joins(:availabilities, :doctors).where("start > (?) AND start <= (?)", (time_start + offset_days.days), Date.today + offset_days.days + nb_days.days).order(:start).merge(search.doctors)
      #       offset_days += 1
      #     end until !search.slots.blank? || offset_days > 7
      #
      #     searches = [search]
      #
      #   end
      #
      #   params do
      #     requires :id, type: String, desc: "ID of the search"
      #   end
      #
      #   get ":id", root: :search, serializer: SearchSerializer do
      #     { "declared_params" => declared(params) }
      #
      #     search = Search.find(params[:id])
      #
      #     #Nb of days you want to search
      #     nb_days = params[:nb_days] || Settings.search.default_nb_days
      #
      #     #Search by latitude and longitude or address
      #     # if !search_params[:lat].nil? && !search_params[:lon].nil?
      #     #   lookup = [search_params[:lat], search_params[:lon]]
      #     # else
      #     #   lookup = search_params[:addr]
      #     # end
      #     lookup = [search.lat, search.lon]
      #
      #     #Radius
      #     radius = search.radius || Settings.search.default_radius
      #
      #     #Search all doctors in the selected area, ordered by distance
      #     search.doctors = Doctor.joins(:categories).where("category_id = ?", search.category_id).near(lookup, radius)
      #
      #     #Find available slots in a week
      #     offset_days = 0
      #     begin
      #       search.slots = Slot.includes(:availabilities, :doctors).joins(:availabilities, :doctors).where("start > (?) AND start <= (?)", (Time.zone.now + 1.hours + offset_days.days), Date.today + offset_days.days + nb_days.days).order(:start).merge(search.doctors)
      #       offset_days += 1
      #     end until !search.slots.blank? || offset_days > 7
      #
      #     search
      #
      #   end
      # end
    end
  end
end
