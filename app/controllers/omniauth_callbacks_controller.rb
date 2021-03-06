class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_authorization_check

  def facebook
    # render json: request.env['omniauth.auth']
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end
  end

  def twitter
    # render json: request.env['omniauth.auth']
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted? && @user.email.match(/twitter/)
      sign_in @user
      redirect_to profile_path
    else
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    end
    # @user = User.find_for_oauth(request.env['omniauth.auth'])
    # if @user.persisted?
    # 	sign_in_and_redirect @user, event: :authentication
    # 	set_flash_message(:notice,:success,kind: "Facebook") if is_navigational_format?
    # end
  end
end
