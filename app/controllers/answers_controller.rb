class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question
  before_action :set_answer, only: [:destroy]

  def create
    @answer =  @question.answers.new(answer_params)
    @answer.user =  current_user
    @answer.save   
         
  end

  def new
    @answer =  Answer.new
  end


  def update
    @answer =  Answer.find(params[:id])  
    @old_best_answer = Answer.where({ question: @answer.question, best: true }).first        
    #byebug
    if params[:answer][:best] =="true" 
      @old_best_answer.update({best:false}) unless @old_best_answer.blank? 
      #byebug
    end
    @answer.update(answer_params)   
  end


  def destroy
    if current_user.id == @answer.user.id
      #byebug
      @answer.destroy
      flash[:notice] = 'Answer successfully deleted'
    else
      #byebug
      flash[:notice] = 'You are not allowed to delete this answer'
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
