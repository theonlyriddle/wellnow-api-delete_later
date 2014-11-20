class AddBackgroundToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :background, :string
  end
end
