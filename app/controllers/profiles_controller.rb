class ProfilesController < ApplicationController
  skip_authorization_check
  def show
  end

  def update
    current_user.update(user_params)
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
