require_relative 'acceptance_helper'
feature 'User can watch question and answers related', '
   In order to ffind the answer to my question
   As authed user or guest
   I want to be able to be able to watch answers of each question

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question_with_valid_answers) }

  scenario 'User or guest watches question and its answers' do
    visit question_path(question)
    expect(page).to have_content('You are beautiful!', count: 5)
  end
end
