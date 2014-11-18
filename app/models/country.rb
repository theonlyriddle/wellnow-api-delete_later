class Country < ActiveRecord::Base
    has_many :doctors

    scope :default, -> { where(default: true) }
end
