class Doctor < ActiveRecord::Base
  belongs_to :country

  validates :firstname, :lastname, :address, :zipcode, :locality, :country_id, :email, :phone, presence: true
end
