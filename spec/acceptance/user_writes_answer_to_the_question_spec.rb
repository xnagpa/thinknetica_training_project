require 'rails_helper'
feature 'User writes answer to the question', '
   In order to make everyone know about my awesomeness
   As authed user
   I want to be able to be able to create a comment for the question

' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'Authed user creates comment' do
    FactoryGirl.create(:question)

    sign_in(user)

    visit questions_path

    click_on 'Create new comment'

    fill_in 'Content', with: 'Test comment and some crap'

    click_on 'Create Answer'

    expect(page).to have_content 'Answer successfully created'
  end

  scenario 'Non Authed user cant create a  comment' do
    FactoryGirl.create(:question)

    visit questions_path

    click_on 'Create new comment'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
