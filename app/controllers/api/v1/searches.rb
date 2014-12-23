module API
  module V1
    class Searches < Grape::API
      include API::V1::Defaults

      resource :search do
        desc "Search for doctors"
        params do
          requires :cat, type: Integer
          optional :lat, type: Float
          optional :lon, type: Float
          optional :addr, type: String
          optional :radius, type: Float
          optional :nb_days, type: Integer
        end
        
        #get "", root: :search, serializer: SearchSerializer do
        get "", root: :search, serializer: SearchSerializer do
          { "declared_params" => declared(params) }

          #Nb of days you want to search
          nb_days = params[:nb_days] || Settings.search.default_nb_days
          
          #Search by latitude and longitude or address
          if !params[:lat].nil? && !params[:lon].nil?
            lookup = [params[:lat], params[:lon]]
          else
            lookup = params[:addr]
          end

          #Radius
          radius = params[:radius] || Settings.search.default_radius

          search = Search.new(:category_id => params['cat'], :lat => params['lat'], :lon => params['lon'], :radius => radius)

          #Search all doctors in the selected area
          search.doctors = Doctor.joins(:categories).where("category_id = ?", params[:cat]).near(lookup, radius)
          search.slots = Slot.includes(:doctors).joins(:doctors).where("start > now() AND start <= (?)", Date.today + nb_days.days).order(:start).merge(search.doctors)
          search

          #Group the available doctors per time slot
          #
          
          #Time.zone
          
          #Availability.select('firstname, lastname').joins(doctor: :categories).where("category_id = ?", params[:cat]).near(lookup, radius).order(:slot_start)
          #availabilities = Availability.joins(:doctor).where("doctor_id IN (?) AND slot_start > now() AND slot_start <= (?)", doctor_ids, Date.today + nb_days.days).order(:slot_start)

          #availabilities.push Availability.last

        end

        desc "Return a doctor"
        params do
          requires :id, type: String, desc: "ID of the doctor"
        end
        get ":id", root: "doctor" do
          Doctor.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end