class Api::V1::QuestionsController < ApplicationController
  # skip_authorization_check

  before_action :doorkeeper_authorize!

  respond_to :json

  authorize_resource 

  def index
    respond_with(@questions = Question.all)
  end

  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_ability 
    @current_ability ||= Ability.new(current_resource_owner)
  end
 
  
end
