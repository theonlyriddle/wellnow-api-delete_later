class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :place
      t.boolean :is_all_day, default: false
      t.datetime :datetime_from
      t.datetime :datetime_to
      t.boolean :is_recurring, default: false
      t.string :schedule
      t.boolean :has_end_of_recurrence, default: false
      t.datetime :end_of_recurrence
      t.integer :parent_id
      t.references :doctor, index: true

      t.timestamps null: false
    end
  end
end
