class RestaurantsController < ApplicationController
  def index
  	@restaurants = Restaurant.all
  end

  def show
  	@restaurant = Restaurant.find_by(id: params["id"])
    if @restaurant
  	  cookies["restaurant_id"] = @restaurant.id
    end
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
  	restaurant.save
  	redirect_to "/"
  end

  def update
  	restaurant = Restaurant.find_by(id: params["id"])
  	restaurant.table_number = params["number"]
  	restaurant.save
  	redirect_to "/"
  end

  def destroy
  	restaurant = Restaurant.find_by(id: params["id"])
  	restaurant.delete
  	redirect_to "/"
  end

end
