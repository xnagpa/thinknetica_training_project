require_relative 'acceptance_helper'

feature 'User creates question and attaches file', '
   In order to get answer from other users
   As authed user
   I want to be able to be able to ask questions with file exapmles

' do

  given(:user) { FactoryGirl.create(:user) }
  given(:user_with_questions) { FactoryGirl.create(:user_with_question) }
  given!(:question) { FactoryGirl.create(:question, user: user) }

  scenario 'User attaches one file to existing question', js: true do
    sign_in(user)
    visit questions_path   
      click_on 'Edit stupid question'
       
        fill_in 'question[content]', with: 'Test edit question'        
        first(".add_fields").click
        files = all("input[type='file']")
        files[0].set('#{Rails.root}/spec/spec_helper.rb')
        save_and_open_page
        submits =all("input[name='commit']")
        submits[0].click      
         
        expect(page).to have_content("spec_helper.rb");
  end

  scenario 'User attaches multiple files to existing question', js: true do
    sign_in(user)
    visit questions_path
      click_on 'Edit stupid question'
       
        fill_in 'question[title]', with: 'Test edit question' 
        fill_in 'question[content]', with: 'Test edit question' 
        click_on "add attachment" 
        click_on "add attachment" 

        files = all("input[type='file']")
        files[0].set('#{Rails.root}/spec/spec_helper.rb')
        files[1].set('#{Rails.root}/spec/spec_helper.rb')
        
        click_on 'Save'
          
        expect(page).to have_content("spec_helper.rb", count: 2);
  end

  
end
