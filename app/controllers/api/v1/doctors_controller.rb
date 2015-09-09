module Api
  module V1
    class DoctorsController < JSONAPI::ResourceController
      # def get_related_resources
      #  if params[:slot_id]
      #    docs = Slot.find(params[:slot_id]).doctors
      #    docs.each do |doc|
      #      doc.distance = 0
      #    end
      #  end
      # end
    end
  end
end
