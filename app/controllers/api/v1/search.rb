module API
  module V1
    class Search < Grape::API
      include API::V1::Defaults

      resource :search do
        desc "Search for doctors"
        params do
          requires :category, type: Integer
          optional :latitude, type: Float
          optional :longitude, type: Float
        end
        get "", root: :doctors do
          { "declared_params" => declared(params) }
          Doctor.joins(:doctors_categories).where("category_id = ?", params[:category])
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