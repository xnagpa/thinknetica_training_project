require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }

	 describe 'POST #create' do
    before { sign_in(user) }
 
      it 'saves a new comment in the database' do

       current_params = { question_id: question.id, comment: { content: "Test comment" }, format: :js }

       expect { post :create, current_params }.to change(Comment, :count).by(1)

      end

      it 'ensures that created comment has user_id of its creator' do

      	current_params = { question_id: question.id, comment: { content: "Test comment" }, format: :js }

        post :create, current_params

        expect(Comment.last.user_id).to eq subject.current_user.id

      end

    end 
 

end
