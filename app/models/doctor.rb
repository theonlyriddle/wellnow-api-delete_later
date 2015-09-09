class Doctor < ActiveRecord::Base
  belongs_to :country
  has_and_belongs_to_many :categories
  has_many :availabilities, :dependent => :delete_all
  has_many :slots, :through => :availabilities
  has_many :availability_generals, :dependent => :delete_all
  has_many :capacities, :dependent => :delete_all
  has_many :procedures, through: :capacities
  has_many :bookings
  has_many :events
  has_many :distances
  has_many :searches, through: :distances

  validates :firstname, :lastname, :address, :zipcode, :locality, :country_id, :email, :phone, presence: true

  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :availability_generals

  geocoded_by :full_street_address

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_create :add_default_capacities, :create_default_general_availability

  mount_uploader :avatar, AvatarUploader
  mount_uploader :background, BackgroundUploader

  has_paper_trail

  scope :available_at, ->(day, time) {
    joins(:availability_generals).where("day = ?", day)
  }

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
    "http://localhost:3000" + self.avatar.mini.url
  end

  def background_cropped_url
    self.background.cropped.url
  end

  private

    def create_default_general_availability
      Time.zone = time_zone
      # Set up 8:00 - 12:00 and 13:00 - 18:00 on weekdays by default
      morning_start = Time.zone.parse("2012-03-02 08:00:00")
      morning_end = Time.zone.parse("2012-03-02 12:00:00")
      afternoon_start = Time.zone.parse("2012-03-02 13:00:00")
      afternoon_end = Time.zone.parse("2012-03-02 18:00:00")
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 1, 'hour_from' => morning_start, 'hour_to' => morning_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 1, 'hour_from' => afternoon_start, 'hour_to' => afternoon_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 2, 'hour_from' => morning_start, 'hour_to' => morning_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 2, 'hour_from' => afternoon_start, 'hour_to' => afternoon_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 3, 'hour_from' => morning_start, 'hour_to' => morning_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 3, 'hour_from' => afternoon_start, 'hour_to' => afternoon_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 4, 'hour_from' => morning_start, 'hour_to' => morning_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 4, 'hour_from' => afternoon_start, 'hour_to' => afternoon_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 5, 'hour_from' => morning_start, 'hour_to' => morning_end)
      AvailabilityGeneral.create('doctor_id' => id, 'day' => 5, 'hour_from' => afternoon_start, 'hour_to' => afternoon_end)
      Time.zone = 'UTC'
    end

    def add_default_capacities
      categories.each do |cat|
        self.procedures << Procedure.where("category_id" => cat.id)
      end
    end
end
