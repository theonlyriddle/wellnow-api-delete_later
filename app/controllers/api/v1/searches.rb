module API
  module V1
    class Searches < Grape::API
      include API::V1::Defaults

      resource :search do
        desc "Create a search"
        params do
          group :search, type: Hash do
            requires :cat, type: Integer
            optional :lat, type: Float
            optional :lon, type: Float
            optional :addr, type: String
            optional :radius, type: Float
            optional :nb_days, type: Integer
          end
        end
        
        post "", root: :search do
          { "declared_params" => declared(params) }

          search_params = params[:search]

          #Nb of days you want to search
          nb_days = search_params[:nb_days] || Settings.search.default_nb_days
          
          #Search by latitude and longitude or address
          if !search_params[:lat].nil? && !search_params[:lon].nil?
            lookup = [search_params[:lat], search_params[:lon]]
          else
            lookup = search_params[:addr]
          end

          #Radius
          radius = search_params[:radius] || Settings.search.default_radius

          search = Search.create!(:category_id => search_params['cat'], :lat => search_params['lat'], :lon => search_params['lon'], :radius => radius)

          search.doctors = []
          search.slots = []

          search

        end

        desc "Search for doctors"
        params do
          requires :cat, type: Integer
          optional :lat, type: Float
          optional :lon, type: Float
          optional :addr, type: String
          optional :radius, type: Float
          optional :nb_days, type: Integer
        end
        
        get "", root: :searches, each_serializer: SearchSerializer do
          { "declared_params" => declared(params) }

          search_params = params

          #Nb of days you want to search
          nb_days = search_params[:nb_days] || Settings.search.default_nb_days
          
          #Search by latitude and longitude or address
          if !search_params[:lat].nil? && !search_params[:lon].nil?
            lookup = [search_params[:lat], search_params[:lon]]
          else
            lookup = search_params[:addr]
          end

          #Radius
          radius = search_params[:radius] || Settings.search.default_radius

          #Paging
          offset_days = 0
          time_start = Time.zone.now + 1.hours

          search = Search.where(:category_id => search_params['cat'], :lat => search_params['lat'], :lon => search_params['lon'], :radius => radius).last

          # search = Search.last

          #Search all doctors in the selected area, ordered by distance
          search.doctors = Doctor.joins(:categories).where("category_id = ?", search.category_id).near(lookup, radius)

          #Find available slots in a week
          begin
            search.slots = Slot.includes(:availabilities, :doctors).joins(:availabilities, :doctors).where("start > (?) AND start <= (?)", (time_start + offset_days.days), Date.today + offset_days.days + nb_days.days).order(:start).merge(search.doctors)
            offset_days += 1
          end until !search.slots.blank? || offset_days > 7

          searches = [search]



        end

        params do
          requires :id, type: String, desc: "ID of the search"
        end
        
        get ":id", root: :search, serializer: SearchSerializer do
          { "declared_params" => declared(params) }

          search = Search.find(params[:id])

          #Nb of days you want to search
          nb_days = params[:nb_days] || Settings.search.default_nb_days
          
          #Search by latitude and longitude or address
          # if !search_params[:lat].nil? && !search_params[:lon].nil?
          #   lookup = [search_params[:lat], search_params[:lon]]
          # else
          #   lookup = search_params[:addr]
          # end
          lookup = [search.lat, search.lon]

          #Radius
          radius = search.radius || Settings.search.default_radius

          #Search all doctors in the selected area, ordered by distance
          search.doctors = Doctor.joins(:categories).where("category_id = ?", search.category_id).near(lookup, radius)

          #Find available slots in a week
          offset_days = 0
          begin
            search.slots = Slot.includes(:availabilities, :doctors).joins(:availabilities, :doctors).where("start > (?) AND start <= (?)", (Time.zone.now + 1.hours + offset_days.days), Date.today + offset_days.days + nb_days.days).order(:start).merge(search.doctors)
            offset_days += 1
          end until !search.slots.blank? || offset_days > 7

          search

        end
      end
    end
  end
end