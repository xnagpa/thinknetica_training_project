class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :extract_question_id, only: [:show, :destroy, :update]

  respond_to :html, :js

  authorize_resource
  # use load_and_authorize_resourse to load @question
  # override def resourse if you want to customize the behaviour

  def index
    # authorize! :index, Question
    # authorize! :read, Question
    respond_with(@questions = Question.includes([:answers, :attachments]).paginate(page: params[:page]))
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = 'Question successfully created'
      @subscription =   @question.subscriptions.create(user: current_user)
      respond_with(@question)
    end
  end

  def new
    # authorize! :create, Question
    @question = Question.new
    @attachment = @question.attachments.new
    respond_with(@question)
  end

  def show
    # authorize! :read, @question
    @answer = @question.answers.build
    @attachment = @answer.attachments.build
    @subscription = Subscription.where(user: current_user, subscrivable: @question).first
    respond_with(@question)
  end

  def destroy
    # authorize! :destroy, @question
    respond_with(@question.destroy)
  end

  def update
    @question.update(question_params)
    respond_with(@question)
  end

  private

  def extract_question_id
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, attachments_attributes: [:file, :id, :_destroy])
  end
end
