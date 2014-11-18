class Category < ActiveRecord::Base
    translates :title, :description, fallbacks_for_empty_translations: true

    active_admin_translates :title, :description do
        validates_presence_of :title
    end
end
