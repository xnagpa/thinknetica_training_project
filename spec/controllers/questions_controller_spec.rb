require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question_with_answers) { FactoryGirl.create(:question_with_valid_answer) }
  let(:user) { FactoryGirl.create(:user) }

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
    before do
      sign_in(user)
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
    before { sign_in(user) }

    let(:factory_question) { FactoryGirl.build(:question) }

    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { post :create, question: FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to show' do
        post :create, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to(action: 'show', id: Question.last)
      end

      it 'ensures that created question has user_id of its creator' do
        post :create, question: FactoryGirl.attributes_for(:question)
        expect(Question.last.user_id).to eq subject.current_user.id
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

  describe 'DELETE #destroy' do
    let!(:question_to_delete) { FactoryGirl.create(:question_with_valid_answer) }
    let!(:question_by_another_user) { FactoryGirl.create(:question_made_by_other_user) }
    before { sign_in(user) }

    it 'deletes question  with given id' do
      expect { delete :destroy, id: question_to_delete }.to change(Question, :count).by(-1)
    end

    it 'doesnt delete question made by other user' do
      expect { delete :destroy, id: question_by_another_user }.to_not change(Question, :count)
    end

    it 'redirect to index view' do
      delete :destroy, id: question_to_delete
      expect(response).to redirect_to root_path
    end
  end
end
