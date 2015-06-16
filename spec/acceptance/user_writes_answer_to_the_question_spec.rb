require 'rails_helper'
feature 'User writes answer to the question', '
   In order to make everyone know about my awesomeness
   As authed user
   I want to be able to be able to create a comment for the question

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question) }

  scenario 'Authed user creates comment' do    
    sign_in(user)

    visit question_path(question)
    click_on 'Create new comment'
    fill_in 'Content', with: 'Test comment and some crap'
    click_on 'Create Answer'
    expect(page).to have_content 'Answer successfully created'
    expect(page).to have_content 'Test comment and some crap'
  end

  scenario 'Non Authed user cant create a  comment' do
    FactoryGirl.create(:question)
    visit questions_path
    click_on 'Create new comment'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end