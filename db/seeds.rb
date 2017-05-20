# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.delete_all
Restaurant.create name: "KFC", table_number: 10
Restaurant.create name: "Mac", table_number: 1
Restaurant.create name: "ShakeShack",table_number: 5 
Restaurant.create name: "PandaExpress",table_number: 4 
Restaurant.create name: "GyuKaku", table_number: 8

User.delete_all
Reservation.delete_all


["Cookie Monster", "Abraham Lincoln", "Luke Skywalker", "Harry Potter",
"Mary Poppins", "Dorothy Gale", "Luna Lovegood", "bygong"].each do |name|
    puts name
    User.create name: name, password: name, points: 0, admin: name=="bygong"

end
puts User.count

TimeSegment.delete_all
DateSegment.delete_all

dates = ["20170601","20170602","20170603", "20170604", "20170605", "20170606" ,"20170607"]

Restaurant.all.each do |restaurant|
  dates.each do |m|
    dat = DateSegment.new
    dat.restaurant = restaurant
    dat.date = DateTime.parse(m).strftime('%Y-%m-%d')
    dat.save
    12.times do |n|
      seg = TimeSegment.new
      seg.restaurant = restaurant
      seg.time = n + 11
      seg.date_segment = dat
      seg.table_left = restaurant.table_number-1
      seg.save
      Reservation.create time_segment_id: seg.id, customer: User.sample, size: rand(1..6)
    end
  end
end


puts "There are now:"
puts "  #{TimeSegment.count} time segments"
puts "  #{DateSegment.count} date segments"
puts "  #{Restaurant.count} different restaurants"
puts "  #{User.count} user accounts"
puts "  #{Reservation.count} reservations"
