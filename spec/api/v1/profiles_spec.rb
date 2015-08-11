require 'rails_helper'

describe 'Profile API' do
  describe 'get /me' do
    context 'unauthorized' do
      it 'returns 401 if no access token' do
        get '/api/v1/profiles/me', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 if no access token is invalid' do
        get '/api/v1/profiles/me', format: :json, access_token: 123
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { FactoryGirl.create(:user) }
      let(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      %w(id email created_at updated_at admin).each do |attr|
        it 'contain #{attr}' do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it 'contain #{attr}' do
          expect(response.body).to_not have_json_path(attr)
        end
      end

      it 'returns 200' do
        expect(response).to be_success
      end
    end
  end

  describe 'get /index' do
    context 'unauthorized' do
      it 'returns 401 if no access token' do
        get '/api/v1/profiles', format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 if no access token is invalid' do
        get '/api/v1/profiles', format: :json, access_token: 123
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { FactoryGirl.create(:user) }
      let!(:smb_else) { FactoryGirl.create(:another_user) }
      let!(:smb_else2) { FactoryGirl.create(:another_user) }
      let!(:smb_else3) { FactoryGirl.create(:another_user) }
      let(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles', format: :json, access_token: access_token.token }

      it 'contain all users except me' do
        expect(response.body).to have_json_size(3).at_path("profiles")

      end

      it 'doesnt contain me' do
        expect(response.body).to_not include_json(me.to_json)
      end

      # %w(password encrypted_password).each do |attr|
      # 	it 'contain #{attr}' do
      # 			expect(response.body).to_not have_json_path(attr)
      # 	end
      # end

      it 'returns 200' do
        expect(response).to be_success
      end
    end
  end
end
