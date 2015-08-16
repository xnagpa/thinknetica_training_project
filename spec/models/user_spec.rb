require 'rails_helper'

RSpec.describe User do
  let!(:user) { FactoryGirl.create(:user) }
  let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
  it { expect(subject).to validate_presence_of :email }
  it { expect(subject).to validate_presence_of :password }

  it { expect(subject).to belong_to(:subscrivable) }
  describe '.find_for_oauth' do
    # user is new
    # user is old but never authed through facebook
    context 'user doesnt have authorization' do
      context 'user exists' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first
          expect(authorization.provider).to eq(auth.provider)
          expect(authorization.uid).to eq(auth.uid)
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'newuser@userland.com' }) }
        it 'creates new user' do
          expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end
        it 'returns new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end
        it 'creates email for new user' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.info.email
        end
        it 'creates authorization for new user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end
        it 'fills proper provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first
          expect(authorization.uid).to eq auth.uid
          expect(authorization.provider).to eq auth.provider
        end
      end
    end
    # user is old and authed through facebook
    context 'user is old and authed through facebook' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end
  end

end
