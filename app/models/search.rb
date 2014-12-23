class Search < ActiveRecord::Base
    belongs_to :category
    has_many :doctors

    # def doctors=(docs)
    #     doctors = docs
    # end

    # def doctors
    #     doctors
    # end

    # def available_slots=(slots)
    #     available_slots = slots
    # end

    # def available_slots
    #     available_slots
    # end
end
