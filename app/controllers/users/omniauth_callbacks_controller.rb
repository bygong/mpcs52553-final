class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication, notice: 'success'
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      session["user_id"] = @user.id
    else
      puts @user.errors.to_a
      puts request.env["omniauth.auth"]
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to '/users/new'
    end
  end

  def failure
    redirect_to '/'
  end
end