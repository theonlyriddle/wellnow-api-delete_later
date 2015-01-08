class CreateProcedures < ActiveRecord::Migration
  def up
    create_table :procedures do |t|
      t.integer :default_length, default: 15
      t.references :category, index: true

      t.timestamps
    end

    Procedure.create_translation_table! :name => :string

    create_table :capacities do |t|
      t.belongs_to :doctor, index: true
      t.belongs_to :procedure, index: true
      t.integer :length
      t.timestamps null: false
    end
  end
  def down
    drop_table :procedures
    drop_table :capacities
    Procedure.drop_translation_table!
  end 
end
