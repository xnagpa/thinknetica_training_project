require_relative 'acceptance_helper'
feature 'In order to improve my answer
        As authed user
        I want to edit my answer
' do
  given(:user) { FactoryGirl.create(:user) }
  given(:user_with_questions) { FactoryGirl.create(:user_with_question) }

  given!(:question) { FactoryGirl.create(:question, user: user) }
  given!(:answer) { FactoryGirl.create(:answer, question:  question, user: user) }

  scenario 'Authed user edit his answer', js: true do
    sign_in(user)
    visit question_path(question)
    save_and_open_page

    within('.answers') do
       click_on 'Edit'
    end

    within('.answers') do
      fill_in 'answer[content]', with: 'Test edit answer'
    end
    within('.answers') do
      click_on 'Save'
    end
    within('.answers') do
      expect(page).to have_content('Test edit answer')
      expect(page).to_not have_content answer.content
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario 'Authed user can\'t edit somebody\'s answer', js: true do
    sign_in(user_with_questions)
    visit question_path(question)
    expect(page).to_not have_content('Edit')
  end

  scenario 'Guest can\'t edit somebody\'s answer', js: true do
    visit question_path(question)
    expect(page).to_not have_content('Edit')
  end
end
