class QuestionsController < ApplicationController
	
	def index
		@questions = Question.all
	end

	def create
		@question = Question.new(question_params)

		respond_to do |format|
      		if @question.save
      			 flash[:notice] = "Question successfully created"
       			 format.html { redirect_to root_path}

       			
      		else
        		format.html { render :new } 
        		
        		flash[:notice] = "Your parameters are not okay, try once again"

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
