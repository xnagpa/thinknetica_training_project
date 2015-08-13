class Api::V1::QuestionsController < Api::V1::BaseController
  # skip_authorization_check
  protect_from_forgery with: :null_session

  before_action :extract_question_id, only: [:show, :destroy, :update]

  authorize_resource

  def index
    @questions = Question.all
    respond_with(@questions, each_serializer: QuestionSerializer)
  end

  def show
    respond_with(@question, serializer: SingleQuestionSerializer)
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_resource_owner
    @question.save
    respond_with(@question, serializer: SingleQuestionSerializer)
  end

  private

  def extract_question_id
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:file, :id, :_destroy])
  end
end
