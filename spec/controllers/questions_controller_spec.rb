require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									  
	describe 'Test index' do
		before{ get :index}

		context 'responds with 200'	do
			it { should respond_with(200)}
		end

		context 'render index template'	do
			it { should render_template('index')}	
		end

		
		context 'render questions partial'	do
			
			it { should render_template(partial:'questions')}
		end
		
	end

	describe 'Test create' do 

		it	do should permit(:title, :content).
	      for(:create).
	      on(:question)
	  	end

	end

	describe 'Routing' do 
		it { should route(:get,'/questions').to(action: :index)}

	end

end
