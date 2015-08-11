require 'rails_helper'

describe "Question API" do
	describe 'get /questions' do

		context 'unauthorized' do

		  it 'returns 401 if no access token' do
				get '/api/v1/questions', format: :json
				expect(response.status).to eq 401
		 end

		 	it 'returns 401 if no access token is invalid' do
				get '/api/v1/questions', format: :json, access_token: 123
				expect(response.status).to eq 401
			end
		end

		 context 'authorized' do
		 	let(:me) { FactoryGirl.create(:user) }
      let!(:questions) { FactoryGirl.create_list(:question, 2) }
			let!(:question) { questions.first }
      let(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: me.id) }
		  let!(:answer){FactoryGirl.create(:answer, question:question)}

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

		 	it 'returns list of questions' do
		 		 expect(response.body).to have_json_size(2).at_path("questions")
		 	end

			it 'returns short title' do
				 expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("questions/0/short_title")
		 	end

		 	it 'returns 200' do
        expect(response).to be_success
      end

			%w(id content created_at updated_at).each do |attr|
				it "has attr #{attr}" do
				  expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
				end
			end

			context 'answers' do

				before { get '/api/v1/questions', format: :json, access_token: access_token.token }

				it "has attr answers" do
					expect(response.body).to have_json_size(1).at_path("questions/0/answers")
				end

				%w(id content created_at updated_at).each do |attr|
					it "has attr #{attr}" do

					  expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
					end
				end

			end

			context 'single question create/show ' do

				before { post '/api/v1/questions', format: :json, access_token: access_token.token }

				it "changes Question count" do
					expect(post '/api/v1/questions', format: :json, access_token: access_token.token).to change (Question, :count).by(1)
				end

				%w(id title content created_at updated_at).each do |attr|
					it "has attr #{attr}" do
					  expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
					end
				end

			end

		end





	end
end
