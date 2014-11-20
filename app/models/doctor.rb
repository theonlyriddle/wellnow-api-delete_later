class Doctor < ActiveRecord::Base
  belongs_to :country
  has_and_belongs_to_many :categories

  validates :firstname, :lastname, :address, :zipcode, :locality, :country_id, :email, :phone, presence: true

  accepts_nested_attributes_for :categories

  mount_uploader :avatar, AvatarUploader
  mount_uploader :background, BackgroundUploader

  #has_paper_trail

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
end
