class Doctor < ActiveRecord::Base
  belongs_to :country
  has_and_belongs_to_many :categories

  validates :firstname, :lastname, :address, :zipcode, :locality, :country_id, :email, :phone, presence: true

  accepts_nested_attributes_for :categories
end
