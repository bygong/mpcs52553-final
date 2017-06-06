class RestaurantsController < ApplicationController
  def index
  	@restaurants = Restaurant.all
  end

  def show
  	@restaurant = Restaurant.find_by(id: params["id"])
    # if @restaurant
  	 #  cookies["restaurant_id"] = @restaurant.id
    # end
  end

  def new
  end

  def edit
  	@restaurant = Restaurant.find_by(id: params["id"])
  end

  def create
  	restaurant = Restaurant.new
  	restaurant.name = params["name"]
  	restaurant.table_number = params["table_number"].to_i
    dates = ["20170601","20170602","20170603", "20170604", "20170605", "20170606" ,"20170607"]
  	restaurant.save
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
        seg.table_left = restaurant.table_number
        seg.save
      end
    end
  	redirect_to "/"
  end

  def update
  	restaurant = Restaurant.find_by(id: params["id"])
  	restaurant.table_number = params["table_number"].to_i
    restaurant.name = params["name"]
  	restaurant.save
  	redirect_to "/"
  end

  def destroy
  	restaurant = Restaurant.find_by(id: params["id"])
  	restaurant.destroy
  	redirect_to "/"
  end

  def all_reservation
    @restaurant = Restaurant.find_by(id: params["id"])
    @user = User.find_by(id: session["user_id"])
    if not @user.present?
      redirect_to "/login", notice: "Please sign in first"
    end
    if not @user.admin
      redirect_to "/", notice: "Unauthorized"
    end

    @all_reservation = []
    Reservation.all.each do |reservation|
      if reservation.time_segment.restaurant == @restaurant
        @all_reservation.push({:user => reservation.customer,
                              :date => reservation.time_segment.date_segment.date,
                              :time => reservation.time_segment.time.to_s,
                              :restaurant => reservation.time_segment.restaurant,
                              :size => reservation.size,
                              :id => reservation.id})
      end
    end
  end

  def stat
    @user = User.find_by(id: session["user_id"])
    if not @user.present?
      redirect_to "/login", notice: "Please sign in first"
    end
    if not @user.admin
      redirect_to "/", notice: "Unauthorized"
    end

    @rank_users = User.all.sort_by do |item|
      item.points
    end.reverse

    restaurants = Hash.new
    Restaurant.all.each do |restaurant|
      restaurants[restaurant.name] = 0
    end

    Reservation.all.each do |reservation|
      restaurants[reservation.time_segment.restaurant.name] += reservation.size.to_i
    end

    @rank_restaurants = restaurants.to_a.sort_by do |item|
      item[1]
    end.reverse
  end

end
