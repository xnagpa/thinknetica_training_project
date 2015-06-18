require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  
  let(:user){ FactoryGirl.create(:user) }
  let(:question){ FactoryGirl.create(:question, user: user) }
  let(:answer){ FactoryGirl.create(:answer, question:  question, user: user) }
  #let(:invalid_answer){ FactoryGirl.create(:invalid_answer, question:  question, user: user) }
  let(:another_user){  FactoryGirl.create(:another_user) }

  describe 'GET #new' do
    before do
      sign_in(user)
      params = { question_id: question}
      get :new, params
    end

    it 'assigns new variable to @answer of the @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new template' do
      expect(response).to render_template('answers/new')
    end
  end
  ###############################
  describe 'delete #destroy' do
      
    it 'deletes answer of the signed in owner' do
      sign_in(user)
      
      answer_to_delete = answer
      current_users_answer_params = { question_id: question, id: answer_to_delete }

      expect { delete :destroy, current_users_answer_params }.to change(user.answers, :count).by(-1)
    end

    it 'doesnt delete answer made by other user' do
      sign_in(another_user)      
      answer_to_delete = answer
      current_users_answer_params = { question_id: question, id: answer_to_delete }

      expect { delete :destroy, current_users_answer_params }.to_not change(user.answers, :count)
    end
  end
  ######################################
  describe 'POST #create' do
    # before :each do
    # valid_answer_attrs = { question_id: question_with_answers.id, answer: FactoryGirl.attributes_for(:answer) }
    # invalid_answer_attrs = { answer: FactoryGirl.attributes_for(:invalid_answer) }
    # question_attrs = { question_id: question_with_answers.id }
    before do      
      sign_in(user)
    end

    let(:post_params_valid) {{question_id: question.id}.merge({answer: FactoryGirl.attributes_for(:answer), format: :js})}
    let(:post_params_invalid) {{question_id: question.id}.merge({answer: FactoryGirl.attributes_for(:invalid_answer), format: :js})}
    #let(:post_params_invalid)
    # end

    context 'with valid attributes' do

      it 'saves a new answer in the database' do  
        expect{post :create, post_params_valid}.to change(Answer,:count).by(1)
      end

      it 'render template create' do
        post :create, post_params_valid
        expect(response).to render_template :create
      end

      it 'ensures that created question has user_id of its creator' do
        post :create, post_params_valid,format: :js
        expect(Answer.last.user_id).to eq subject.current_user.id
      
      end
    end

    context 'with invalid attributes' do
      it "doesn't save a new question in the database" do
        post :create, post_params_invalid
        expect { post :create, post_params_invalid }.to_not change(Answer, :count)
      end

      it 'rerenders new template' do
        post :create, post_params_invalid
        expect(response).to render_template('answers/new')
      end
    end
  end
end
