class Country < ActiveRecord::Base
    has_many :doctors

    validates :name, :iso, presence: true

    scope :default, -> { where(default: true) }
end
