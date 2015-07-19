require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let(:author) { FactoryGirl.create(:another_user) }
  let!(:question) { FactoryGirl.create(:question, user: author) }
  let!(:answer) { FactoryGirl.create(:answer,  question:  question, user: author) }
  let!(:vote){FactoryGirl.create(:vote, user:user)}

  # Аутентифицированный пользователь может голосовать за понравившийся вопрос/ответ +
  # Пользователь не может голосовать за свой вопрос/ответ +
  # Пользователь может проголосовать "за" или "против" конкретного вопроса/ответа
  # только один раз (нельзя голосовать 2 раза подряд "за" или "против") +
  # Пользователь может отменить свое решение и после этого переголосовать.
  # У вопроса/ответа должен выводиться результирующий рейтинг (разница между голосами
  # "за" и "против")

  describe 'post #create'  do
    it 'doesn\'t create a vote for guest' do
      current_params = { question_id: question.id, vote: { score: 1 }, format: :js }
      # polymorphic_path([votable, Vote.new], vote:{score:1}
      expect { post :create, current_params }.not_to change(Vote, :count)
    end

    it 'doesn\'t create a vote for creator' do
      sign_in(author)

      current_params = { question_id: question.id, vote: { score: 1 }, format: :js }

      expect { post :create, current_params }.not_to change(Vote, :count)
    end

    it 'doesn\'t creates a vote for non-creator' do
      sign_in(user)

      current_params = { question_id: question.id, vote: { score: 1 }, format: :js }

      expect { post :create, current_params }.to change(Vote, :count).by(1)
    end

    it 'doesn\'t change Vote count if voted twice' do
      sign_in(user)

      current_params =  { question_id: question.id, vote: { score: 1 }, format: :js }

      expect { post :create, current_params }.to change(Vote, :count).by(1)

      current_params =  { question_id: question.id, vote: { score: 1 }, format: :js }

      expect { post :create, current_params }.not_to change(Vote, :count)
    end

    it ' gives to user  opportunity to revote' do
      sign_in(user)

      current_params = { question_id: question.id, vote: { score: 1 }, format: :js }

      expect { post :create, current_params }.to change(Vote, :count).by(1)

      current_params = { question_id: question.id, vote: { score: -1 }, format: :js }

      expect { post :create, current_params }.to change(Vote, :count).by(1)
    end


     it 'User can delete his vote' do
      sign_in(user)
      expect { delete :destroy, id:vote, format: :js }.to change(Vote, :count).by(-1)
    end
  end
end
