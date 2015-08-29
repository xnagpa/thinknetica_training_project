require 'rails_helper'

describe 'Answers API' do
  let(:me) { FactoryGirl.create(:user) }
  let!(:single_question) { FactoryGirl.create(:question) }
  let!(:question) { FactoryGirl.create(:question) }
  let!(:answer) { FactoryGirl.create(:answer, question: question) }
  let!(:answer2) { FactoryGirl.create(:answer, question: question) }

  let!(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: me.id) }

  let!(:comment) { FactoryGirl.create(:comment, commentable: answer, user: me) }
  let!(:attachment) { FactoryGirl.create(:attachment, attachable: answer) }
  #
  #
  # let!(:answer){FactoryGirl.create(:answer, question:single_question)}

  describe 'get questions/1/answers' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it 'returns list of answers for question' do
        expect(response.body).to have_json_size(2).at_path('answers')
      end

      it_behaves_like 'good request'

      %w(id content created_at updated_at).each do |attr|
        it "has attr #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
    def do_request(options = {})
      get '/api/v1/questions/1/answers', { format: :json }.merge(options)
    end
  end

  describe 'get question/1/answers/1' do
    before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token }

    it_behaves_like 'API Authenticable'

    it_behaves_like 'good request'

    it 'has attr attachments' do
      expect(response.body).to have_json_size(1).at_path('single_answer/attachments')
    end

    it 'has attr comments' do
      expect(response.body).to have_json_size(1).at_path('single_answer/comments')
    end

    %w(id content created_at updated_at).each do |attr|
      it "has attr #{attr}" do
        expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("single_answer/#{attr}")
      end
    end
    def do_request(options = {})
      get "/api/v1/questions/#{question.id}/answers/#{answer.id}", { format: :json }.merge(options)
    end
  end

  describe 'post question/1/answers' do
    it_behaves_like 'API Authenticable'

    it 'changes count of the Answers' do
      # /api/v1/questions/:question_id/answers(.:format)
      expect { post "/api/v1/questions/#{question.id}/answers", answer: FactoryGirl.attributes_for(:answer), format: :json, access_token: access_token.token }.to change(Answer, :count).by(1)
    end
    def do_request(options = {})
      post "/api/v1/questions/#{question.id}/answers", { format: :json }.merge(options)
    end
  end
end
