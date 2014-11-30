class Doctor < ActiveRecord::Base
  belongs_to :country
  has_and_belongs_to_many :categories
  has_many :availability_generals, :dependent => :delete_all

  validates :firstname, :lastname, :address, :zipcode, :locality, :country_id, :email, :phone, presence: true

  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :availability_generals

  geocoded_by :full_street_address

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_create :create_default_general_availability

  mount_uploader :avatar, AvatarUploader
  mount_uploader :background, BackgroundUploader

  has_paper_trail

  def full_name
    firstname + " " + lastname
  end

  def full_address
    if !address2.empty?
      address + ", " + address2
    else
      address
    end
  end

  def full_street_address
    full_address + ", " + zipcode + " " + locality +  ", " + country.name
  end

  def avatar_url
    self.avatar.url
  end

  def background_url
    self.background.url
  end

  def avatar_bigthumb_url
    self.avatar.bigthumb.url
  end

  def avatar_thumb_url
    self.avatar.thumb.url
  end

  def avatar_mini_url
    self.avatar.mini.url
  end

  def background_cropped_url
    self.background.cropped.url
  end

  private

    def create_default_general_availability
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 1, 'hour_from' => "08:00", 'hour_to' => "12:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 1, 'hour_from' => "13:00", 'hour_to' => "18:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 2, 'hour_from' => "08:00", 'hour_to' => "12:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 2, 'hour_from' => "13:00", 'hour_to' => "18:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 3, 'hour_from' => "08:00", 'hour_to' => "12:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 3, 'hour_from' => "13:00", 'hour_to' => "18:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 4, 'hour_from' => "08:00", 'hour_to' => "12:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 4, 'hour_from' => "13:00", 'hour_to' => "18:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 5, 'hour_from' => "08:00", 'hour_to' => "12:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 5, 'hour_from' => "13:00", 'hour_to' => "18:00")
    end
end
