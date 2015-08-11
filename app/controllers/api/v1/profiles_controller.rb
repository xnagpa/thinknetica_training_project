class Api::V1::ProfilesController < Api::V1::BaseController
  # skip_authorization_check



  authorize_resource class: User

  def me
    #authorize! :me, current_resource_owner
    respond_with current_resource_owner
  end

  def index
    #authorize! :index, current_resource_owner
    respond_with other_users
  end

  protected


  def other_users
    @users ||= User.where.not(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_ability
    @current_ability ||= Ability.new(current_resource_owner)
  end
end
