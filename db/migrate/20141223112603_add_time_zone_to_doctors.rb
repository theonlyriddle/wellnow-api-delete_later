class AddTimeZoneToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :time_zone, :string
  end
end
