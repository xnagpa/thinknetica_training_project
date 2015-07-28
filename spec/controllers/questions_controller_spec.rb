require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }
  let(:answer) { FactoryGirl.create(:answer, question:  question, user: user) }
  let(:another_user) {  FactoryGirl.create(:another_user) }

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

    it 'assigns new variable to @attachment' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
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
        expect { post :create, question: FactoryGirl.attributes_for(:question), format: :js }.to change(Question, :count).by(1)
      end

      it 'redirects to show' do
        post :create, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to(action: 'show', id: Question.last)
      end

      it 'ensures that created question has user_id of its creator' do
        post :create, question: FactoryGirl.attributes_for(:question)
        expect(Question.last.user).to eq subject.current_user
      end
    end

    context 'with invalid attributes' do
      it "doesn't save a new question in the database" do
        expect { post :create, question: FactoryGirl.attributes_for(:invalid_question), format: :js  }.to_not change(Question, :count)
      end
      
    end
  end

  describe 'GET #show' do
    before { get :show, id: question.id }

    it 'assings the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new variable to @attachment' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'assings generated answer to @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    let!(:question_to_delete) { FactoryGirl.create(:question, user: user) }
    let!(:another_question_to_delete) { FactoryGirl.create(:question, user: user) }
    it 'deletes question  with given id' do
      sign_in(user)
      expect { delete :destroy, id: question_to_delete }.to change(Question, :count).by(-1)
    end

    it 'doesnt delete question made by other user' do
     sign_in(user)
      expect { delete :destroy, id: another_question_to_delete }.to change(Question, :count).by(-1)
    end

   
  end

  describe 'patch #update' do
    context 'does ' do
      let!(:question_to_update) { FactoryGirl.create(:question, user: user) }

      it 'assign @question ' do
        sign_in(user)
        patch :update, id: question_to_update, question: FactoryGirl.attributes_for(:question), format: :js
        expect(assigns(:question)).to eq question_to_update
      end

      it 'render template create' do
        sign_in(user)
        patch :update, id: question_to_update, question: FactoryGirl.attributes_for(:question), format: :js
        expect(response).to render_template :update
      end

      it 'changes the original content off the answer' do
        sign_in(user)
        patch :update, id: question_to_update, question: { title: 'crap', content: 'new crap' }, format: :js
        question_to_update.reload
        expect(question_to_update.content).to eq 'new crap'
        expect(question_to_update.title).to eq 'crap'
      end

      it 'doesnt change if another user tries to change it' do
        sign_in(another_user)
        patch :update, id: question_to_update, question: { title: 'crap', content: 'new crap' }, format: :js
        question_to_update.reload
        expect(question_to_update.content).not_to eq 'new crap'
      end
    end
  end
end
