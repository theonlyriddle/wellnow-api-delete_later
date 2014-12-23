class Search < ActiveRecord::Base
    belongs_to :category
    #has_many :doctors

    def doctors=(docs)
        @doctors = docs
    end

    def doctors
        @doctors
    end

    def slots=(slots)
        @slots = slots
    end

    def slots
        @slots
    end
end
