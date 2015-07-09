require_relative 'acceptance_helper'
feature 'In order to improve my question
        As authed user
        I want to edit my question
' do
  given(:user) { FactoryGirl.create(:user) }
  given(:user_with_questions) { FactoryGirl.create(:user_with_question) }
  given!(:question) { FactoryGirl.create(:question, user: user) }

  scenario 'Authed user edit his question', js: true do
    sign_in(user)
    visit question_path(question)

    within('.question') do
      click_on 'Edit stupid question'

      fill_in 'question[content]', with: 'Test edit question'

      click_on 'Save'
    end

    

    within('.question') do
      expect(page).to have_content('Test edit question')
      expect(page).to_not have_content question.content
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario 'Authed user can\'t edit somebody\'s question', js: true do
    sign_in(user_with_questions)
    visit question_path(question)
    expect(page).to_not have_content('Edit')
  end

  scenario 'Guest can\'t edit somebody\'s question', js: true do
    visit question_path(question)
    expect(page).to_not have_content('Edit')
  end
end
