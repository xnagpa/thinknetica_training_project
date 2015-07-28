class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :extract_question_id, only: [:show, :destroy, :update]

  respond_to :html,:js

  def index
    respond_with(@questions = Question.includes([:answers,:attachments]).all)
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
     flash[:notice] = 'Question successfully created' 
     respond_with(@question)
    end   
  end

  def new
    @question = Question.new
    @attachment = @question.attachments.new
    respond_with(@question)
  end

  def show
    @answer = @question.answers.build
    @attachment = @answer.attachments.build
    respond_with(@question)
  end

  def destroy      
    respond_with(@question.destroy)  if current_user.id == @question.user_id
  end

  def update
    if current_user.id == @question.user_id
      @question.update(question_params) 
      respond_with(@question)
    end
  end

  private

  def extract_question_id
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:file, :id, :_destroy])
  end
end
