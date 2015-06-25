require_relative 'acceptance_helper'

feature 'User can choose best answer', '
   In order to choose the best answer
   As a user
   I want to be able to make it bold

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:question){ FactoryGirl.create(:question, user: user) }
  given(:answer){ FactoryGirl.create(:answer,  question:  question)} 
  given(:another_answer){ FactoryGirl.create(:answer,  question:  question)} 

  
 
  #given(:question_with_valid_answers){ FactoryGirl.create(:question_with_valid_answers) }
 
  scenario 'Author can choose the best answer', js: true do
    # sign_in(user)   
   
    # visit question_path(question)
    # last('.answer').click_link('Be the best!')   
    # expect(page).to have_tag(".answers answer:nth-child(1)", text: @date1.content)
    

  end

  scenario 'There is only one best answer', js: true do
    # visit question_path(question)
    # expect(first('.answer')).to have_css()
  end

  scenario 'Best answer should be the first on the page', js: true do
    # visit question_path(question)
    # expect(first('.answer')).to have_css()
  end

  scenario 'Author can change his mind and choose another answer', js: true do
    
  end

  scenario 'Non-author can\'t choose the best answer', js: true do
    
  end
end
