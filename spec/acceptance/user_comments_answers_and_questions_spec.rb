require_relative 'acceptance_helper'
feature 'User comments question or answer', '
   In order to chat
   As authed user
   I want to be able to leave comments to question and answer

' do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:question) { FactoryGirl.create(:question, user: user) }
  given!(:comment){ FactoryGirl.create(:comment,commentable:question, user: user)}
  scenario 'Authed user creates comment', js:true do
    visit question_path(question)
    sign_in(user)
   
    click_on 'Leave a comment'     
 
     within("#comment-question-1 .inputs"){ fill_in("comment[content]", with: "Test comment")}  
 
    save_and_open_page
    expect(page).to have_content 'Test comment'
  end

  scenario 'Non authed user tries to create comment', js:true do
    visit questions_path
    expect(page).not_to have_content 'Leave a comment'
  end

  scenario 'Authed user deletes his comment', js:true do
    visit questions_path
    sign_in(user)
   
    click_on 'Delete stupid comment'
    expect(page).not_to have_content 'Test comment'

  end
end
