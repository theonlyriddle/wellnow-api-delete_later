class Procedure < ActiveRecord::Base
    belongs_to :category
    has_many :capacities
    has_many :doctors, through: :capacities

    translates :name

    has_many :category_translations
    
    accepts_nested_attributes_for :translations
end
