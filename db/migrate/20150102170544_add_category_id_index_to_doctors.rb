class AddCategoryIdIndexToDoctors < ActiveRecord::Migration
  def change
    add_index :categories_doctors, [:doctor_id, :category_id]
  end
end
