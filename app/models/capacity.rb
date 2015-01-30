class Capacity < ActiveRecord::Base
    belongs_to :doctor
    belongs_to :procedure

    before_create :set_default_length_if_empty

    def name
        self.procedure.name
    end

    private

        def set_default_length_if_empty
            if length.nil? || length == 0 || length == ""
                self.length = procedure.default_length
            end
        end
end