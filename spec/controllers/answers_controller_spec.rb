require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question_with_answers) { FactoryGirl.create(:question_with_valid_answer) }
  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #new' do
    before do
      sign_in(user)
      params = { question_id: question_with_answers.id }
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
    let!(:question_with_answers_by_other_user) { FactoryGirl.create(:question_answer_by_other_user) }
    before do
      sign_in(user)
    end

    it 'deletes answer of the signed in owner' do
      answer_to_delete = question_with_answers.answers.first
      current_users_answer_params = { question_id: question_with_answers, id: answer_to_delete }

      expect { delete :destroy, current_users_answer_params }.to change(question_with_answers.answers, :count).by(-1)
    end

    it 'doesnt delete answer made by other user' do
      another_answer_to_delete = question_with_answers_by_other_user.answers.first
      another_users_answer_params = { question_id: question_with_answers_by_other_user, id: another_answer_to_delete }
      expect { delete :destroy, another_users_answer_params }.to_not change(question_with_answers.answers, :count)
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

    let!(:post_params_valid) { { question_id: question_with_answers.id, answer: FactoryGirl.attributes_for(:answer) } }
    let!(:post_params_invalid) { { question_id: question_with_answers.id, answer: FactoryGirl.attributes_for(:invalid_answer) } }
    # end

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, post_params_valid }.to change(question_with_answers.answers, :count).by(1)
      end

      it 'redirects to show' do
        post :create, post_params_valid
        expect(response).to redirect_to(question_url(question_with_answers.id))
      end

      it 'ensures that created question has user_id of its creator' do
        post :create, post_params_valid
        expect(Answer.last.user_id).to eq subject.current_user.id
      end
    end

    context 'with invalid attributes' do
      it "doesn't save a new question in the database" do
        expect { post :create, post_params_invalid }.to_not change(Answer, :count)
      end

      it 'rerenders new template' do
        post :create, post_params_invalid
        expect(response).to render_template('answers/new')
      end
    end
  end
end
