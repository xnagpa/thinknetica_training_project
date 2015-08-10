require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.create(:another_user) }

  let!(:attachment) { FactoryGirl.create(:attachment) }
  let!(:question_with_attachments) { FactoryGirl.create(:question_with_attachments, user: user) }

  describe 'delete #destroy'  do
    it 'deletes attachment of the signed in owner' do
      sign_in(user)

      current_params = { id: question_with_attachments.attachments.first, format: :js }

      expect { delete :destroy, current_params }.to change(Attachment, :count).by(-1)
    end

    it 'doesnt delete attachment made by other user' do
      sign_in(another_user)

      current_params = { id: question_with_attachments.attachments.first, format: :js }

      expect { delete :destroy, current_params }.to_not change(Attachment, :count)
    end
  end
end
