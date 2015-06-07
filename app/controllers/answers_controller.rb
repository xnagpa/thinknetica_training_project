class AnswersController < ApplicationController



	def index 
		@question=Question.find(params[:question_id])
		@answers = @question.answers
	end

	def create 
	  @question=Question.find(params[:question_id])
	  @answer =  @question.answers.new(answer_params)

	  if @answer.save 

	  	respond_to do |format|
	  		format.html {redirect_to root_path}
	  		
	  	end	  
	  else
		respond_to do |format|
	  		format.html { render template: 'answers/new'}
	  		
	  	end	 

	  end

	end

	def new 
	  @question=Question.find(params[:question_id])
	  @answer =  @question.answers.new
	end

	def answer_params
		params.require(:answer).permit(:content,:question_id)		
	end
end
