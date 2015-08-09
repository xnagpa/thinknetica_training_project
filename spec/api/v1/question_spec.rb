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

		 context 'authorized' do 
		 	let(:me) { FactoryGirl.create(:user) }
      let!(:smb_else) { FactoryGirl.create(:another_user) }
      let!(:smb_else2) { FactoryGirl.create(:another_user) }
      let!(:smb_else3) { FactoryGirl.create(:another_user) }
      let(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: me.id) }

		 	it 'returns list of questions' do 
		 	end
		 end
	end
end