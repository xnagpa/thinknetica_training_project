require 'rails_helper'

describe 'Profile API' do
  describe 'get /me' do
    it_behaves_like 'API Authenticable'

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

      it_behaves_like 'good request'
    end
    def do_request(options = {})
      get '/api/v1/profiles/me', { format: :json }.merge(options)
    end
  end

  describe 'get /index' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let(:me) { FactoryGirl.create(:user) }
      let!(:smb_else) { FactoryGirl.create(:another_user) }
      let!(:smb_else2) { FactoryGirl.create(:another_user) }
      let!(:smb_else3) { FactoryGirl.create(:another_user) }
      let(:access_token) { FactoryGirl.create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles', format: :json, access_token: access_token.token }

      it 'contain all users except me' do
        expect(response.body).to have_json_size(3).at_path('profiles')
      end

      it 'doesnt contain me' do
        expect(response.body).to_not include_json(me.to_json)
      end

      # %w(password encrypted_password).each do |attr|
      # 	it 'contain #{attr}' do
      # 			expect(response.body).to_not have_json_path(attr)
      # 	end
      # end

      it_behaves_like 'good request'
    end
    def do_request(options = {})
      get '/api/v1/profiles', { format: :json }.merge(options)
    end
  end
end
