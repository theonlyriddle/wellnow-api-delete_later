class AddDefaultTimeZoneToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :default_time_zone, :string
  end
end
