class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question
  before_action :set_answer, only: [:destroy,:update,:set_best_answer]

  def create
    @answer =  @question.answers.new(answer_params)
    @answer.user =  current_user
    @answer.save
  end

  def new
    @answer =  Answer.new
  end

  def update   
    @answer.update(answer_params)
  end

  def destroy
    if current_user.id == @answer.user.id
      @answer.destroy
      flash[:notice] = 'Answer successfully deleted'
    else
      # byebug
      flash[:notice] = 'You are not allowed to delete this answer'
    end
  end

  def set_best_answer 
       if @question.user ==current_user
         @old_best_answer = Answer.get_old_best_answer(@answer.question)         
        Answer.get_rid_of_the_old_best_answer(@answer.question) 
         #byebug
         @answer.update(answer_params) unless @answer==@old_best_answer   
       end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :best)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
 end
end
