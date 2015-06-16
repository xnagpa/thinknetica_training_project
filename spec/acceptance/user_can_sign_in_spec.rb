require 'rails_helper'
feature 'User sign in', '
   In order to ask questions
   As user
   I want to be able to sign in

' do
  given(:user) { FactoryGirl.create(:user) }

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
end