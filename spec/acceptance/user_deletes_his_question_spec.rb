require 'rails_helper'
feature 'User deletes question', '
   In order to hide my stupidity
   As a user
   I want to be able to delete my own question

' do
  given(:user_not_an_author) { FactoryGirl.create(:user) }
  given(:user_with_questions) { FactoryGirl.create(:user_with_question) }
  

  scenario 'Author tries to delete his own crap' do
    sign_in(user_with_questions)

    question_count = user_with_questions.questions.count
    visit question_path(user_with_questions.questions.first)
    click_on 'Delete stupid question'    

    expect(page).to have_content('Factory question', count: question_count-1)
  end

  scenario 'Non-author tries to delete a question' do
    sign_in(user_not_an_author)

    visit question_path(user_with_questions.questions.first)
    expect(page).to_not have_content 'Delete stupid question'   
  end
end
