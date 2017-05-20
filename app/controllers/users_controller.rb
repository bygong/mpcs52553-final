class UsersController < ApplicationController
  
  def new
  	@user = User.new
  end

  def show
    @user = User.find_by({id: params["id"]})
    if @user.id != session["user_id"]
      redirect_to "/"
    end
  end

  def create
  	@user = User.new
  	@user.name = params["name"]
  	@user.password = params["password"]
  	@user.points = 0
  	@user.email_address = params["email"]
  	if @user.save
      session["user_id"] = @user.id
  		redirect_to "/", notice: "Thanks for signing up"
  	else
      message = ""
      @user.errors.full_messages.each do |msg|
        message += msg
        message += ", "
      end
      message = message[0..-3]
  		redirect_to "/users/new", notice: message
  	end
  end

  def update
    user = User.find_by(id: session["user_id"])
    user.name = params["name"]
    user.password = params["password"]
    user.email_address = params["email"]
    if user.save
      redirect_to "/", notice: "profile updated"
    else
      message = ""
      user.errors.full_messages.each do |msg|
        message += msg
        message += ", "
      end
      message = message[0..-3]
      redirect_to "/users/#{user.id}", notice: message
    end
  end
end
