class CreateDistances < ActiveRecord::Migration
  def change
    create_table :distances do |t|
      t.float :calculated_distance
      t.references :search, index: true
      t.references :doctor, index: true

      t.timestamps null: false
    end
    add_foreign_key :distances, :searches
    add_foreign_key :distances, :doctors
  end
end
