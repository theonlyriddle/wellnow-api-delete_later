class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    belongs_to :country

    before_save :ensure_authentication_token

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

    def ensure_authentication_token
        if authentication_token.blank?
          self.authentication_token = generate_authentication_token
        end
    end

    private

        def generate_authentication_token
            loop do
                token = Devise.friendly_token
                break token unless User.where(authentication_token: token).first
            end
        end
end
