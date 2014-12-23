module API
  module V1
    class Searches < Grape::API
      include API::V1::Defaults

      resource :search do
        desc "Search for doctors"
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
        
        post "", root: :search, serializer: SearchSerializer do
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

          search = Search.new(:category_id => search_params['cat'], :lat => search_params['lat'], :lon => search_params['lon'], :radius => radius)

          #Search all doctors in the selected area
          search.doctors = Doctor.joins(:categories).where("category_id = ?", search_params[:cat]).near(lookup, radius)
          search.slots = Slot.includes(:doctors).joins(:doctors).where("start > (?) AND start <= (?)", Time.zone.now + 1.hours, Date.today + nb_days.days).order(:start).merge(search.doctors)
          search

        end

        params do
          requires :cat, type: Integer
          optional :lat, type: Float
          optional :lon, type: Float
          optional :addr, type: String
          optional :radius, type: Float
          optional :nb_days, type: Integer
        end
        
        get "", root: :search, serializer: SearchSerializer do
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

          search = Search.new(:category_id => search_params['cat'], :lat => search_params['lat'], :lon => search_params['lon'], :radius => radius)

          #Search all doctors in the selected area
          search.doctors = Doctor.joins(:categories).where("category_id = ?", search_params[:cat]).near(lookup, radius)
          search.slots = Slot.includes(:doctors).joins(:doctors).where("start > (?) AND start <= (?)", Time.zone.now + 1.hours, Date.today + nb_days.days).order(:start).merge(search.doctors)
          search

        end
      end
    end
  end
end