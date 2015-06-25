require_relative 'acceptance_helper'
feature 'User sign out', '
   In order to leave
   As user
   I want to be able to sign out

' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'Registered user tries to sign out' do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully'
    click_on 'Sign out'
    expect(page.current_path).to eq root_path
    # Capybara.current_session.driver.delete destroy_user_session_path(user.id)
    # save_and_open_page
    # sign_out(user)
  end
end
