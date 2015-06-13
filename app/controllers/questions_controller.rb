class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  
  def index
    @questions = Question.all
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question successfully created'
        format.html { redirect_to @question }
      else
        format.html { render :new }
        flash[:notice] = 'Your parameters are not okay, try once again'
      end
    end
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
    end
end
