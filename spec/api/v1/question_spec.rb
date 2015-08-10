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
      let!(:question) { FactoryGirl.create(:question_with_valid_answers) }
      let!(:questions) { FactoryGirl.create_list(:question, 2) }
      let(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

		 	it 'returns list of questions' do 
		 		
		 		 expect(response.body).to have_json_size(2).at_path("questions")
		 	end

		 	it 'returns 200' do
        expect(response).to be_success
      end
		end
	end
end