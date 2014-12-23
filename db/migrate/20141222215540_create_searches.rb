class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.references :category, index: true
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end
end
