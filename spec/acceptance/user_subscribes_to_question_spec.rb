require 'rails_hepler'

feature 'Subscribes to get answers to questio by email ', '
   In order to keep getting the freshest answers
   As authed user
   I want to be able to subscribe

' do
given(:user) { FactoryGirl.create(:user) }
given(:question) { FactoryGirl.create(:question, user: user) }
given(:another_question) { FactoryGirl.create(:question) }

scenario 'Authed user creates question and subscribes to it automatically', js: true do
  sign_in(user)

end

scenario 'Authed user  subscribes to the question', js: true do
  sign_in(user)
  visit question_path(another_question)
  expect(page).to have_content("Follow")
  click_on "Follow"
  expect(page).to have_content("Unfollow")
end

scenario 'Authed user  stops subscribtion', js: true do
  sign_in(user)
  visit question_path(another_question)
  expect(page).to have_content("Unfollow")
  click_on "Unfollow"
  expect(page).to have_content("Follow")
end
end
