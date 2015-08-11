class Api::V1::QuestionsController < Api::V1::BaseController
  # skip_authorization_check
  before_action :extract_question_id, only: [:show, :destroy, :update]


  authorize_resource

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    respond_with(@question)
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.save
    respond_with(@question)
  end

private

  def extract_question_id
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:file, :id, :_destroy])
  end

end
