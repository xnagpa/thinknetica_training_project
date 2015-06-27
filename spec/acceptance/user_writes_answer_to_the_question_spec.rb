require_relative 'acceptance_helper'
feature 'User writes answer to the question', '
   In order to make everyone know about my awesomeness
   As authed user
   I want to be able to be able to create a comment for the question

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question) }

  scenario 'Authed user creates comment', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Your answer', with: 'Test comment and some crap'

    click_on 'Create'

    expect(current_path).to eq question_path(question)

    within '.answers' do
      expect(page).to have_content 'Test comment and some crap'
    end
  end

  scenario 'Non Authed user cant create a  comment', js: true do
    visit question_path(question)
    expect(page).to_not have_content 'Create'
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Create'
    save_and_open_page
    expect(page).to have_content 'Content can\'t be blank'
  end
end
