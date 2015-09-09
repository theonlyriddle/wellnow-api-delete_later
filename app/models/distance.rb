class Distance < ActiveRecord::Base
  belongs_to :search
  belongs_to :doctor

  validates :doctor, uniqueness: { scope: :search,
    message: "distance can be calculated only once a search" }
end
