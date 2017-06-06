class SessionsController < ApplicationController
  
  def destroy
  	reset_session
  	redirect_to "/", notice: "Logged off successfully"
  end

  def new

  end

  def create
  	user = User.find_by(name: params["name"])
  	if user.present?
  		if user.authenticate(params['password'])
          session["user_id"] = user.id
  			redirect_to "/", notice: "Welcome back, #{user.name}"
  		else
  			redirect_to "/login"
  		end
  	else
  		redirect_to "/login"
  	end
  end

  def create_auth
    user = User.from_omniauth(env["omniauth.auth"])
    session["user_id"] = user.id
    redirect_to '/'
  end

end
