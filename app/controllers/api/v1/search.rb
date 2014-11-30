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
        end
        get "", root: :doctors do
          { "declared_params" => declared(params) }
          
          #Search by latitude and longitude or address
          if !params[:lat].nil? && !params[:lon].nil?
            lookup = [params[:lat], params[:lon]]
          else
            lookup = params[:addr]
          end

          #Radius
          radius = params[:radius] || Settings.search.default_radius

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