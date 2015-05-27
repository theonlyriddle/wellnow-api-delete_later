class Country < ActiveRecord::Base
    has_many :doctors
    has_many :users

    validates :name, :iso, presence: true

    scope :default, -> { where(default: true) }
end
