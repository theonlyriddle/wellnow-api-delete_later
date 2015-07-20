module Api
  module V1
    class CategoryResource < JSONAPI::Resource
      attributes :title, :description, :rank
    end
  end
end
