require_relative 'acceptance_helper'
feature 'User sign in', '
   In order to ask questions
   As user
   I want to be able to sign in

' do
  given(:user) { FactoryGirl.create(:user) }
  given!(:authorization) { FactoryGirl.create(:authorization, user: user) }

  scenario 'Registered user tries to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Non-eegistered user tries to sign in' do
    visit new_user_session_path # new_user_session_path
    fill_in 'Email', with: 'some113@mail.com'
    fill_in 'Password', with: '1231332112'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Non-registered user tries to sign in via twitter' do
    visit root_path
    new_user_mock_hash
    click_on 'Sign in'

    click_on 'Sign in with Twitter'

    expect(page).to have_content 'Provide your email please'    
   
    fill_in("user_email", with: "some113@mail.com")
    click_on "Save"
   
    expect(current_path).to eq root_path
  end

  scenario 'Registered user tries to sign in via twitter' do
       
    visit root_path
    old_user_mock_hash
    click_on 'Sign in'

    click_on 'Sign in with Twitter'

    expect(page).to have_content 'Successfully authenticated from Twitter account'    
   
   
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user tries to sign in via facebook' do
    visit root_path
    fb_new_user_mock_hash
    click_on 'Sign in'

    click_on 'Sign in with Facebook'    
   
    expect(current_path).to eq root_path
  end

  scenario 'Registered user tries to sign in via facebook' do
       
    visit root_path
    fb_old_user_mock_hash
    click_on 'Sign in'

    click_on 'Sign in with Facebook'

    expect(page).to have_content 'Successfully authenticated from Facebook account'    
   
   
    expect(current_path).to eq root_path
  end


end
