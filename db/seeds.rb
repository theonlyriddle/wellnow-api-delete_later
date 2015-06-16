# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sql = "TRUNCATE TABLE slots CASCADE"
ActiveRecord::Base.connection.execute sql

#Creates slots for a year
inserts = []
#Check if they are available
from_date = Date.today
to_date = Date.today + 10.years
(from_date..to_date).each { |d|
    #Loop around the hours
    for hour in 0..23
      [0, 15, 30, 45].each { |minutes|
        checked_time = Time.new(d.year, d.month, d.day, hour, minutes, 0)
        if (checked_time >= Time.now)
            inserts.push "('#{checked_time}', now())"
        end
      }
    end
}
sql = "INSERT INTO slots (\"start\", \"created_at\") VALUES #{inserts.join(", ")}"
ActiveRecord::Base.connection.execute sql

BookingStatus.create([{name: 'Pending', is_default: true, is_active: false}, {name: 'Success', is_default: false, is_active: true}, {name: 'Cancelled', is_default: false, is_active: false}])
