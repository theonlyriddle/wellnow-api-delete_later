class Category < ActiveRecord::Base
    translates :title, :description, fallbacks_for_empty_translations: true
    has_and_belongs_to_many :doctors, through: :doctors_categories

    active_admin_translates :title, :description do
        validates_presence_of :title
    end
end
