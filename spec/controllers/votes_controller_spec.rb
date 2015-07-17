require 'rails_helper'

RSpec.describe VotesController, type: :controller do

	let!(:user) { FactoryGirl.create(:user) }
  let(:author) { FactoryGirl.create(:another_user) }
  let!(:question) { FactoryGirl.create(:question, user: author) }
  let!(:answer) { FactoryGirl.create(:answer,  question:  question, user: author) }


 

 # Аутентифицированный пользователь может голосовать за понравившийся вопрос/ответ +
    # Пользователь не может голосовать за свой вопрос/ответ +
    # Пользователь может проголосовать "за" или "против" конкретного вопроса/ответа
    # только один раз (нельзя голосовать 2 раза подряд "за" или "против") +
    # Пользователь может отменить свое решение и после этого переголосовать.
    # У вопроса/ответа должен выводиться результирующий рейтинг (разница между голосами
    # "за" и "против")

  describe 'post #create'  do
    it 'doesn\'t create a vote for guest' do

      current_params = { votable:{ id: question.id, votable_type: question.class.name},vote: {thumb_up:1}, format: :js }

      expect { post :create, current_params }.not_to change(Vote, :count)
    end

    it 'doesn\'t create a vote for creator' do
      sign_in(author)

      current_params = { votable:{ id: question.id, votable_type: question.class.name},vote: {thumb_up:1}, format: :js }

      expect { post :create, current_params }.not_to change(Vote, :count)
    end

    it 'doesn\'t creates a vote for non-creator' do
      sign_in(user)

      current_params = { votable:{ id: question.id, votable_type: question.class.name},vote: {thumb_up:1}, format: :js }

      expect { post :create, current_params }.to change(Vote, :count).by(1)
    end

     it 'doesn\'t change Vote count if voted twice' do
      sign_in(user)

      current_params = { votable:{ id: question.id, votable_type: question.class.name},vote: {thumb_up:1}, format: :js }

      expect { post :create, current_params }.to change(Vote, :count).by(1)

      current_params = { votable:{ id: question.id, votable_type: question.class.name},vote: {thumb_up:1}, format: :js }

      expect { post :create, current_params }.not_to change(Vote, :count)
    end

     it 'user can revote' do
      sign_in(user)

      current_params = { votable:{ id: question.id, votable_type: question.class.name},vote: {thumb_up:1}, format: :js }

      expect { post :create, current_params }.to change(Vote, :count).by(1)

      current_params = { votable:{ id: question.id, votable_type: question.class.name},vote: {thumb_down:1}, format: :js }

      expect { post :create, current_params }.not_to change(Vote, :count)
    end

   
  end

end
