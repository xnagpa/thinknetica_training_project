require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question, user: user) }
  let!(:subscription) { FactoryGirl.create(:subscription, user: user) }

  describe 'GET #create' do
    it 'creates new subscription in the db' do
      sign_in(user)
      current_params = { question_id: question.id, subscription: { user_id: user }, format: :js }
      expect { post :create, current_params }.to change(Subscription, :count).by(1)
    end

    it 'ensures that created subscription has user_id of its creator' do
      sign_in(user)
      current_params = { question_id: question.id, subscription: { user_id: user }, format: :js }
      post :create, current_params
      expect(Subscription.last.user).to eq user
    end

    it 'User cant subscribe twice' do
      sign_in(user)
      current_params = { question_id: question.id, subscription: { user_id: user }, format: :js }
      expect { post :create, current_params }.to change(Subscription, :count).by(1)

      current_params = { question_id: question.id, subscription: { user_id: user }, format: :js }
      expect { post :create, current_params }.to_not change(Subscription, :count)
    end
  end

  describe 'GET #destroy' do
    it 'User can delete his subscription' do
      sign_in(user)
      expect { delete :destroy, id: subscription.id, format: :js }.to change(Subscription, :count).by(-1)
    end

    it 'Guest cant delete subscription' do
      expect { delete :destroy, id: subscription.id, format: :js }.to_not change(Subscription, :count)
    end
  end
end
