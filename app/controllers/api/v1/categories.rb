module API
  module V1
    class Categories < Grape::API
      include API::V1::Defaults

      resource :categories do

        desc "Return all categories"
        get "", root: :categories do
          Category.all
        end

        desc "Return a category"
        params do
          requires :id, type: String, desc: "ID of the category"
        end
        get ":id", root: "category" do
          Category.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end