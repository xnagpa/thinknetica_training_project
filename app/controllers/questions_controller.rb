class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :extract_question_id, only: [:show, :destroy, :update]

  def index
    @questions = Question.all
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question successfully created'
        format.html { redirect_to @question }
        format.js
      else
        format.html { render :new }
        format.js
        flash[:notice] = 'Your parameters are not okay, try once again'
      end
    end
  end

  def new
    @question = Question.new
    @attachment = @question.attachments.new
  end

  def show
    @answer = @question.answers.build
    @attachment = @answer.attachments.build
  end

  def destroy
    if current_user.id == @question.user_id
      @question.destroy
      flash[:notice] = 'Question successfully deleted'
    else
      flash[:notice] = 'You are not allowed to delete this question'
    end
    redirect_to root_path
  end

  def update
    @question.update(question_params) if current_user.id == @question.user_id
  end

  private

  def extract_question_id
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:file, :id, :_destroy])
  end
end
