require_relative 'acceptance_helper'

feature 'User creates question and attaches file', '
   In order to get answer from other users
   As authed user
   I want to be able to be able to ask questions with file exapmles

' do

  given(:user) { FactoryGirl.create(:user) }
  given(:user_with_questions) { FactoryGirl.create(:user_with_question) }
  given!(:question) { FactoryGirl.create(:question, user: user) }

  scenario 'Authed user creates question' do
    sign_in(user)
    visit question_path(question)
    click_on('Edit stupid question')
    fill_in 'question[content]', with: 'Test edit question'
    attach_file 'File1', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Save'

    within('.question') do
      expect(page).to have_content('Test edit question')
      expect(page).to_not have_content question.content
      expect(page).to_not have_selector 'textarea'
    end

   
  end

  
end
