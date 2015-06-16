class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question
  before_action :set_answer, only: [:destroy]

  def create
    @answer =  @question.answers.new(answer_params)
    @answer.user =  current_user
    if @answer.save
      redirect_to question_url(@question)
      flash[:notice] = 'Answer successfully created'
    else
      render template: 'answers/new'
      flash[:notice] = 'Your parameters are not okay, try once again'
    end
  end

  def new
    @answer =  Answer.new
  end

  def destroy
    if current_user == @answer.user
      #byebug
      @answer.destroy
      flash[:notice] = 'Answer successfully deleted'
    else
      #byebug
      flash[:notice] = 'You are not allowed to delete this answer'
    end
    redirect_to root_path
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
 end
end
