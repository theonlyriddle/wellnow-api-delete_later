class AddRadiusToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :radius, :float
  end
end
