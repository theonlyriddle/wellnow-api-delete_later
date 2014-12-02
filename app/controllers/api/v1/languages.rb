module API
  module V1
    class Languages < Grape::API
      include API::V1::Defaults

      resource :languages do

        desc "Return all languages"
        get "", root: :languages do
          Language.all.order('rank')
        end

        desc "Return a language"
        params do
          requires :id, type: String, desc: "ID of the language"
        end
        get ":id", root: "language" do
          Language.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end