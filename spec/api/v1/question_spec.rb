require 'rails_helper'

describe 'Question API' do
  let(:me) { FactoryGirl.create(:user) }
  let!(:single_question) { FactoryGirl.create(:question) }
  let!(:question) { FactoryGirl.create(:question) }

  let(:invalid_question) { FactoryGirl.create(:invalid_question) }

  let!(:comment) { FactoryGirl.create(:comment, commentable: single_question, user: me) }
  let!(:attachment) { FactoryGirl.create(:attachment, attachable: single_question) }

  let!(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: me.id) }
  let!(:answer) { FactoryGirl.create(:answer, question: single_question) }

  describe 'get /questions' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      it 'returns short title' do
        expect(response.body).to be_json_eql(single_question.title.truncate(10).to_json).at_path('questions/0/short_title')
      end

      it_behaves_like 'good request'

      %w(id content created_at updated_at).each do |attr|
        it "has attr #{attr}" do
          expect(response.body).to be_json_eql(single_question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

      context 'answers' do
        before { get '/api/v1/questions', format: :json, access_token: access_token.token }

        it 'has attr answers' do
          expect(response.body).to have_json_size(1).at_path('questions/0/answers')
        end

        %w(id content created_at updated_at).each do |attr|
          it "has attr #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end
      end
    end
    def do_request(options = {})
      get '/api/v1/questions', { format: :json }.merge(options)
    end
  end

  describe 'get /questions/1' do
    it_behaves_like 'API Authenticable'

    context 'single question show ' do
      before { get "/api/v1/questions/#{Question.first.id}", format: :json, access_token: access_token.token }

      it_behaves_like 'good request'

      it 'has attr attachments' do
        expect(response.body).to have_json_size(1).at_path('single_question/attachments')
      end

      it 'has attr comments' do
        expect(response.body).to have_json_size(1).at_path('single_question/comments')
      end

      %w(id title content created_at updated_at).each do |attr|
        it "has attr #{attr}" do
          expect(response.body).to be_json_eql(single_question.send(attr.to_sym).to_json).at_path("single_question/#{attr}")
        end
      end
    end
    def do_request(options = {})
      get '/api/v1/questions/1', { format: :json }.merge(options)
    end
  end

  describe 'post /questions' do
    it_behaves_like 'API Authenticable'

    context 'single question create' do
      it 'changes count of the Question' do
        # expect(post '/api/v1/questions', question: FactoryGirl.attributes_for(:question),format: :json, access_token: access_token.token}.to change{Question, :count}.by(1)
        expect { post '/api/v1/questions', question: FactoryGirl.attributes_for(:question), format: :json, access_token: access_token.token }.to change(Question, :count).by(1)
      end

      it "doesn't save a new question in the database if params are invalid" do
        expect { post '/api/v1/questions', question: FactoryGirl.attributes_for(:invalid_question), format: :json, access_token: access_token.token }.to_not change(Question, :count)
      end
    end
    def do_request(options = {})
      post '/api/v1/questions', { format: :json }.merge(options)
    end
  end
end
