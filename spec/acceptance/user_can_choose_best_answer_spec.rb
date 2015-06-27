require_relative 'acceptance_helper'

feature 'User can choose best answer', '
   In order to choose the best answer
   As a user
   I want to be able to make it bold

' do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:question) { FactoryGirl.create(:question, user: user) }
  given!(:answer) { FactoryGirl.create(:answer,  question:  question) }
  given!(:another_answer) { FactoryGirl.create(:another_answer,  question:  question) }
  given!(:another_user) { FactoryGirl.create(:another_user) }

  # given(:question_with_valid_answers){ FactoryGirl.create(:question_with_valid_answers) }

  scenario 'Author can choose the best answer', js: true do
    sign_in(user)
    visit question_path(question)
    first('.answer').click_link('Best ever')
    # Otherwise it doesnt find element
    sleep 1.seconds
    expect(first('.answer')).to have_xpath("//div[@class='answer' and @data-is-best='true']")
  end

  scenario 'There is only one best answer and it situated first on the page', js: true do
    sign_in(user)
    visit question_path(question)
    answers = page.all('.answer')
    answers[1].find('a').click
    sleep 1.seconds
    expect(first('.answer')).to have_xpath("//div[@class='answer' and @data-is-best='true'][1]")
  end

  scenario 'Guest can\'t choose the best answer', js: true do
    visit question_path(question)
    expect(page).not_to have_content('Best ever')
  end

  scenario 'Another user can\'t choose the best answer', js: true do
    sign_in(another_user)
    visit question_path(question)
    expect(page).not_to have_content('Best ever')
  end
end
