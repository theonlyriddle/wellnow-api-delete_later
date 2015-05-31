module API
  module V1
    class Countries < Grape::API
      include API::V1::Defaults

      resource :countries do

        desc "Return all countries"
        get "", root: :countries do
          Country.all.order(default: :desc, name: :asc)
        end

        desc "Return a country"
        params do
          requires :id, type: String, desc: "ID of the country"
        end
        get ":id", root: "country" do
          Country.find(permitted_params[:id])
        end
      end
    end
  end
end
