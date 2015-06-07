require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									  
	describe 'GET #index' do
		let(:factory_questions){FactoryGirl.create_list(:question,2)}
		let(:factory_question_with_answers){FactoryGirl.create(:question_with_valid_answer)}

		before do			
			get :index
		end

		it "fills array of all questions" do		
			
			expect(assigns(:questions)).to match_array(factory_questions)
		end

		it "renders index template" do
			
			expect(response).to render_template(:index)
		end

		it "can fill array of answers" do
			get :index, :question_id => factory_question_with_answers.id
			#byebug
			expect(assigns(:questions).first.answers.count).to eq(factory_question_with_answers.answers.count)
				
		end
		
	end

	describe 'GET #new' do 		
		before do
			get :new
		end	

		it "assigns new variable to @question" do 
			expect(assigns(:question)).to be_a_new(Question)
		end

		it "renders new template" do 
			expect(response).to render_template(:new)
		end
	

	end


	describe 'POST #create' do 	

	let(:factory_question){FactoryGirl.build(:question)}	

	 context "with valid attributes" do 

	 	it "saves a new question in the database" do 
	 		expect {post :create, question: FactoryGirl.attributes_for(:question)}.to change(Question,:count).by(1)
	 	end

	 	it "redirects to index" do 
	 		post :create, question: FactoryGirl.attributes_for(:question)
	 		expect(response).to redirect_to(root_path)
	 	end
	 	
	 end

	  context "with invalid attributes" do 

	 	it "doesn't save a new question in the database" do 	 		
	 		expect {post :create, question: FactoryGirl.attributes_for(:invalid_question)}.to_not change(Question,:count)
	 	end

	 	it "rerenders new template" do 
	 		post :create, question: FactoryGirl.attributes_for(:invalid_question)
	 		expect(response).to render_template(:new)
	 	end
	 	
	 end

	end

	

	describe 'Routing' do 
		it { should route(:get,'/questions').to(action: :index)}

	end

end
