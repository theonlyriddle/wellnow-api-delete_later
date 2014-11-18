class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :address2
      t.string :zipcode
      t.string :locality
      t.string :email
      t.string :locality
      t.references :country, index: true
      t.string :email
      t.string :phone
      t.string :fax
      t.string :mobile

      t.timestamps
    end
  end
end
