module API
  module V1
    class Doctors < Grape::API
      include API::V1::Defaults

      resource :doctors do
        desc "Return all doctors"
        get "", root: :doctors do
          Doctor.all
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