require_relative 'acceptance_helper'
feature 'User can pass the regicstration', '
   In order to become a user and ask questions
   As guest
   I want to be able to sign up

' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'Guest tries to sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'some113@mail.com'
    fill_in 'Password', with: '1231332112'
    fill_in 'Password confirmation', with: '1231332112'

    click_button('Sign up')
    expect(page).to have_content 'Welcome! You have signed up successfully.'

    # page.find('input', name: 'commit').click_link('Delete')

    # expect(current_path).to eq root_path
  end
end
