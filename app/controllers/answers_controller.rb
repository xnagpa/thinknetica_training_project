class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :set_question

  def create
    @answer =  @question.answers.new(answer_params)

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

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  def set_question
    @question = Question.find(params[:question_id])

  end
end
