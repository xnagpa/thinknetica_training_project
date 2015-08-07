class ProfilesController < ApplicationController
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
