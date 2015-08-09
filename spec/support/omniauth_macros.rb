# in spec/support/omniauth_macros.rb
module OmniauthMacros
  def new_user_mock_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new('provider' => 'twitter',
                                                                 'uid' => '123545',
                                                                 'info' => {
                                                                   'name' => 'mockuser',
                                                                   'image' => 'mock_user_thumbnail_url',
                                                                   'email' => nil
                                                                 },
                                                                 'credentials' => {
                                                                   'token' => 'mock_token',
                                                                   'secret' => 'mock_secret'
                                                                 })
  end

  def old_user_mock_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new('provider' => 'twitter',
                                                                 'uid' => '11111111111',
                                                                 'info' => {
                                                                   'name' => 'mockuser',
                                                                   'image' => 'mock_user_thumbnail_url',
                                                                   'email' => nil
                                                                 },
                                                                 'credentials' => {
                                                                   'token' => 'mock_token',
                                                                   'secret' => 'mock_secret'
                                                                 })
  end

  def fb_old_user_mock_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new('provider' => 'facebook',
                                                                  'uid' => '11111111111',
                                                                  'info' => {
                                                                    'name' => 'mockuser',
                                                                    'image' => 'mock_user_thumbnail_url',
                                                                    'email' => nil
                                                                  },
                                                                  'credentials' => {
                                                                    'token' => 'mock_token',
                                                                    'secret' => 'mock_secret'
                                                                  })
  end

  def fb_new_user_mock_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new('provider' => 'facebook',
                                                                  'uid' => '123545',
                                                                  'info' => {
                                                                    'name' => 'mockuser',
                                                                    'image' => 'mock_user_thumbnail_url',
                                                                    'email' => nil
                                                                  },
                                                                  'credentials' => {
                                                                    'token' => 'mock_token',
                                                                    'secret' => 'mock_secret'
                                                                  })
end
end
