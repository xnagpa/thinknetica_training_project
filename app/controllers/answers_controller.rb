class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:destroy, :update, :set_best_answer]

  respond_to :html, :js
  authorize_resource

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    respond_with(@answer) if @answer.save
  end

  def new
    respond_with(@answer = Answer.new)
  end

  def update
    @answer.update(answer_params)
    respond_with(@question)
  end

  def destroy
    respond_with(@answer.destroy)
  end

  def set_best_answer
    respond_with(@answer.make_best)
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :best, attachments_attributes: [:id, :file, :_destroy])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
