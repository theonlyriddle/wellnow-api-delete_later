module API
  module V1
    class Search < Grape::API
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
        get "", root: :search do
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

          #Search all doctors in the selected area
          selected_doctors = []

          #Check if they are available
          from_date = Date.today
          to_date = Date.today + nb_days.days
          (from_date..to_date).each { |d|  
            for hour in 0..23
              [0, 15, 30, 45].each { |minutes|
                checked_time = Time.new(d.year, d.month, d.day, hour, minutes, 0)
                if (checked_time >= Time.now)
                  #selected_doctors.push Doctor.joins(:doctors_categories).where("category_id = ?", params[:cat]).near(lookup, radius).available_at(checked_time.wday, 0)
                  #puts checked_time.strftime("%Y-%m-%d %H:%M")
                end
              }
            end
          }

          #selected_doctors
          #Search all doctors in the selected area
          Doctor.joins(:doctors_categories).where("category_id = ?", params[:cat]).near(lookup, radius)

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