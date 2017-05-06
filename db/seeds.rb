# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.delete_all
Restaurant.create name: "KFC", table_number: 20
Restaurant.create name: "Mac", table_number: 30
Restaurant.create name: "ShakeShack",table_number: 5 
Restaurant.create name: "PandaExpress",table_number: 15 
Restaurant.create name: "GyuKaku", table_number: 40

User.delete_all
Reservation.delete_all

["Cookie Monster", "Abraham Lincoln", "Luke Skywalker", "Harry Potter",
"Mary Poppins", "Dorothy Gale", "Luna Lovegood"].each do |name|
    puts name
    User.create name: name, password: name, points: 0
end
puts User.count

Timesegment.delete_all

Restaurant.all.each do |restaurant|
  12.times do |n|
    seg = Timesegment.new
    seg.restaurant = restaurant
    seg.time = n + 11
    seg.save
    2.times do
      Reservation.create timesegment_id: seg.id, customer: User.sample, size: rand(1..6)
    end
  end
end


puts "There are now:"
puts "  #{Timesegment.count} time segments"
puts "  #{Restaurant.count} different restaurants"
puts "  #{User.count} user accounts"
puts "  #{Reservation.count} reservations"
