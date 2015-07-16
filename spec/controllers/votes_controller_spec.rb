require 'rails_helper'

RSpec.describe VotesController, type: :controller do

	let!(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:another_user) }

  let!(:attachment) { FactoryGirl.create(:attachment) }
  let!(:question_with_attachments) { FactoryGirl.create(:question_with_attachments, user: user) }

  describe 'post #create'  do
    it 'doesn\'t creates a vote for guest' do
      sign_in(user)

      current_params = { id: question_with_attachments.attachments.first, format: :js }

      expect { delete :destroy, current_params }.to change(Attachment, :count).by(-1)
    end

    it 'doesn\'t creates a vote for creator' do
      sign_in(user)

      current_params = { id: question_with_attachments.attachments.first, format: :js }

      expect { delete :destroy, current_params }.to change(Attachment, :count).by(-1)
    end

    it 'doesn\'t creates a vote for non-creator' do
      sign_in(user)

      current_params = { id: question_with_attachments.attachments.first, format: :js }

      expect { delete :destroy, current_params }.to change(Attachment, :count).by(-1)
    end

   
  end

end
