module Api
  module V1
    class DoctorResource < JSONAPI::Resource
      attributes :firstname, :lastname, :address, :address2, :zipcode, :locality, :country_id, :latitude, :longitude, :email, :phone, :fax, :mobile, :avatar_url, :avatar_bigthumb_url, :avatar_thumb_url, :avatar_mini_url, :background_cropped_url, :background_url
      has_many :categories

      filters :lookup, :category_id

      def self.apply_filter(records, filter, value, options)
        case filter
          when :category_id
            records.joins(:categories).where("category_id = ?", value)
          when :lookup
            lookup = [value[0],value[1]]
            radius = value[2] || Settings.search.default_radius
            records.near(lookup, radius)
          else
            return super(records, filter, value)
        end
      end
    end
  end
end
