class Api::V1::AnswersController < Api::V1::BaseController

  before_action :set_question, only: [:index,:show, :create]
  before_action :set_answer, only: [:show]

  authorize_resource

  def index
    @answers = @question.answers
    respond_with(@answers, each_serializer: AnswersSerializer)
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_resource_owner
    @answer.save
    respond_with(@answer, serializer: SingleAnswerSerializer)
  end

  def show
    respond_with(@answer, serializer: SingleAnswerSerializer)
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content, :best)
  end

end
