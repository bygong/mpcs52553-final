class UsersController < ApplicationController
  
  def new
  	@user = User.new
  end

  def create
  	@user = User.new
  	@user.name = params["name"]
  	@user.password = params["password"]
  	@user.points = 0
  	@user.email_address = params["email"]
  	if @user.save
  		redirect_to "/", notice: "Thanks for signing up"
  	else
  		redirect_to "/users/new", notice: "Error"
  	end
  end

end
