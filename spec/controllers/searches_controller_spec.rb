require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }
  let(:answer) { FactoryGirl.create(:answer, question: question, user: user) }
  let(:another_user) { FactoryGirl.create(:another_user) }

  describe 'GET #show' do
    before { get :show, search_type: 'All' }

    it 'renders show view' do
      ThinkingSphinx::Test.run do
        sign_in(user)
        expect(response).to render_template :show
      end
    end
  end
end
