class AddDefaultToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :default, :boolean, :default => false
  end
end
