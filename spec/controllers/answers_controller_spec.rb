require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

	let(:factory_question_with_answers){FactoryGirl.create(:question_with_valid_answer)}
    
	describe "GET #index" do 		
		#index for AnswerController doesn't need to be implemented.
	end

	describe "GET #new" do
		

		before do
			params = { question_id: factory_question_with_answers.id}
			get :new,params
		end	

		it "assigns new variable to @answer of the @question" do 
			expect(assigns(:answer)).to be_a_new(Answer)
		end

		it "renders new template" do 
			expect(response).to render_template('answers/new')
		end
		
	end

	describe "POST #create" do 

		 before :each do
      		
     		@valid_answer_attrs = {answer:FactoryGirl.attributes_for(:answer)}
     		@invalid_answer_attrs= {answer:FactoryGirl.attributes_for(:invalid_answer)}
      		@question_attrs = {question_id:factory_question_with_answers.id}
      		@post_params_valid = @question_attrs.merge(@valid_answer_attrs)
      		@post_params_invalid = @question_attrs.merge(@invalid_answer_attrs)

   		 end

		context "with valid attributes" do 

			it "saves a new answer in the database" do 	
								
				expect {post :create,@post_params_valid}.to change(Answer,:count) 		
	 		end

	 		it "redirects to index" do 
	 			post :create,@post_params_valid	
	 			expect(response).to redirect_to(root_url)
	 		end
		end

		context "with invalid attributes" do 

			it "doesn't save a new question in the database" do 				
				expect {post :create,@post_params_invalid}.to_not change(Answer,:count) 	
			end

	        it "rerenders new template" do 
	        	post :create,@post_params_invalid
	        	expect(response).to render_template('answers/new')
	        end
		end
	end
	

	describe 'Routing' do 
		it { should route(:get,'/questions/1/answers').to( 'answers#index', question_id:1)}
		
	end

end
