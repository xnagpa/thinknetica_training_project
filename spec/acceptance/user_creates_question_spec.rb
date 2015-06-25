require_relative 'acceptance_helper'
feature 'User creates question', '
   In order to get answer from other users
   As authed user
   I want to be able to be able to ask questions

' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'Authed user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Create new question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Content', with: 'texttext'
    click_on 'Save'

    expect(page).to have_content 'Question successfully created'
     expect(page).to have_content 'Test question'
      expect(page).to have_content 'texttext'
  end

  scenario 'Non authed user tries to create question' do
    visit questions_path
    click_on 'Create new question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
