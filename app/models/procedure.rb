class Procedure < ActiveRecord::Base
  belongs_to :category
  has_many :capacities
  has_many :doctors, through: :capacities

  translates :name
end
