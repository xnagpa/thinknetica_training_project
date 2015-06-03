require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

	describe 'Test controller' do
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

		it	do should permit(:content, :question_id).
	      for(:create).
	      on(:answer)
	  	end

	end

	describe 'Routing' do 
		it { should route(:get,'/questions/1/answers').to( 'answers#index', question_id:1)}
		
	end

end
