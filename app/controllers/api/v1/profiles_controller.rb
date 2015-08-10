class Api::V1::ProfilesController < ApplicationController
  # skip_authorization_check

  before_action :doorkeeper_authorize!

  respond_to :json

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

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_ability 
		@current_ability ||= Ability.new(current_resource_owner)
  end

  def other_users
    @users ||= User.where.not(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
