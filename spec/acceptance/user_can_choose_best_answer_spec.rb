require_relative 'acceptance_helper'

feature 'User can choose best answer', '
   In order to choose the best answer
   As a user
   I want to be able to make it bold

' do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:question) { FactoryGirl.create(:question, user: user) }
  given!(:answer) { FactoryGirl.create(:answer,  question:  question, user: user) }
  given!(:another_user) { FactoryGirl.create(:another_user) }
  given(:another_answer) { FactoryGirl.create(:another_answer,  question:  question, user: user) }

  # given(:question_with_valid_answers){ FactoryGirl.create(:question_with_valid_answers) }

  scenario 'Author can choose the best answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Best ever'

    # find(".answer[id='#{answer.id}'] .best-answer-link").click
    expect(page).to have_css('.answer.best_answer')
  end

  scenario 'There is only one best answer and it is situated first on the page', js: true do
    sign_in(user)
    # I dont need 2 answers in the previous test
    # That's why I don't use given!  from the begining
    another_answer

    visit question_path(question)
    
    links = page.all('.answer a.best-answer-link')
    links[1].click   
  
    expect(page).to have_css('.answer.best_answer')

    expect(first('.answer.best_answer')[:id]).to eq 'answer-1'
    # find(".answer[id='#{another_answer.id}'] .best-answer-link")
    # expect(find(".answer[id='answer-#{another_answer.id}']")).to have_css(".answer.best_answer")
    # expect(first('.answer')).to have_xpath("//div[@class='answer' and @data-is-best='true'][1]")
  
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
