class SessionsController < ApplicationController
  
  def destroy
  	cookies.delete("user_id")
  	redirect_to "/"
  end

  def new

  end

  def create
  	user = User.find_by(name: params["name"])
  	if user.present?
  		if user.password == params['password']
  			cookies["user_id"] = user.id
  			redirect_to "/", notice: "Welcome back, #{user.name}"
  		else
  			redirect_to "/login"
  		end
  	else
  		redirect_to "/login"
  	end
  end

end
