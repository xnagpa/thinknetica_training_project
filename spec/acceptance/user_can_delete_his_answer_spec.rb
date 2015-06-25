require_relative 'acceptance_helper'
feature 'User deletes answer', '
   In order to hide my stupidity
   As a user
   I want to be able to delete my own answer

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:answer){ FactoryGirl.create(:answer)}
 
  #given(:question_with_valid_answers){ FactoryGirl.create(:question_with_valid_answers) }
 
  scenario 'Author tries to delete his own crappy answer', js: true do
    sign_in(answer.user)   
   
    visit question_path(answer.question)
    click_on 'Delete stupid answer'    
    expect(page).to_not have_content answer.content
  end

  scenario 'Non-author tries to delete an answer', js: true do
    sign_in(user)    
    visit question_path(answer.question)

    expect(page).to_not have_content 'Delete stupid answer'
  end
end
