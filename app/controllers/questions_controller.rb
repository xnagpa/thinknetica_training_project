class QuestionsController < ApplicationController
	
	def index
		@questions = Question.all
	end

	def create
		@question = Question.new(question_params)

		respond_to do |format|
      		if @question.save
       			 format.html { redirect_to root_path}
       			
      		else
        		format.html { render :new }       		   
      	end      	
    end

	end

	def new
		@question = Question.new
	end

	private

	def question_params
      params.require(:question).permit(:title, :content)
    end



end
