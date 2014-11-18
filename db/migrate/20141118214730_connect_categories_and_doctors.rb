class ConnectCategoriesAndDoctors < ActiveRecord::Migration
  def change
    create_table :categories_doctors, id: false do |t|
        t.belongs_to :doctor
        t.belongs_to :category
    end
  end
end