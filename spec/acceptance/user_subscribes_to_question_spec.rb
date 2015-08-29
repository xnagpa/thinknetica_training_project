require_relative 'acceptance_helper'

feature 'Subscribes to get answers to questio by email ', '
   In order to keep getting the freshest answers
   As authed user
   I want to be able to subscribe

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question) }
  given(:another_question) { FactoryGirl.create(:question) }
  given!(:subscription) { FactoryGirl.create(:subscription, subscrivable: another_question, user: user) }

  # scenario 'Authed user creates question and subscribes to it automatically', js: true do
  #   sign_in(user)
  #
  # end
  #
  scenario 'Guest cant use subscription', js: true do
    visit question_path(another_question)
    expect(page).to_not have_content('Follow')
  end

  scenario 'Authed user  subscribes to the question', js: true do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content('Follow')
    click_on 'Follow'
    sleep 3
    expect(page).to have_content('Unfollow')
  end

  scenario 'Authed user  stops subscribtion', js: true do
    sign_in(user)
    visit question_path(another_question)
    expect(page).to have_content('Unfollow')
    click_on 'Unfollow'
    sleep 3
    expect(page).to have_content('Follow')
  end
end
