require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question_with_answers) { FactoryGirl.create(:question_with_valid_answer) }

  describe 'GET #index' do
    let(:generated_questions) { FactoryGirl.create_list(:question, 2) }

    before do
      get :index
    end

    it 'fills array of all questions' do
      expect(assigns(:questions)).to match_array(generated_questions)
    end

    it 'renders index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
   sign_in_user

    before do
      get :new
    end

    it 'assigns new variable to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    sign_in_user
    let(:factory_question) { FactoryGirl.build(:question) }

    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { post :create, question: FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to show' do
        post :create, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to(action: 'show', id: Question.last)
      end
    end

    context 'with invalid attributes' do
      it "doesn't save a new question in the database" do
        expect { post :create, question: FactoryGirl.attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 'rerenders new template' do
        post :create, question: FactoryGirl.attributes_for(:invalid_question)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    before { get :show, id: question_with_answers.id }

    it 'assings the requested question to @question' do
      expect(assigns(:question)).to eq question_with_answers
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
