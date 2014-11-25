class Contact < ActiveRecord::Base
    validates :email, uniqueness: true
    validates :first_name, :last_name, :email, :title, presence: true

    def language
        I18n.locale
    end
end
