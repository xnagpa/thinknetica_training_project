require 'rails_helper'
feature 'User deletes answer', '
   In order to hide my stupidity
   As a user
   I want to be able to delete my own answer

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:another) { FactoryGirl.create(:another_user) }

  scenario 'Author tries to delete his own crappy answer' do
    sign_in(user)
    visit root_path
    click_on 'Create new question'

    fill_in 'Title', with: 'Some title'
    fill_in 'Content', with: 'Question to delete later'
    click_on 'Create'
    expect(page).to have_content 'Question successfully created'

    click_on 'Create new comment'
    fill_in 'Content', with: 'Answer to delete later'
    click_on 'Create'
    expect(page).to have_content 'Answer successfully created'

    click_on 'Delete stupid answer'

    expect(page).to have_content 'Answer successfully deleted'
  end

  scenario 'Non-author tries to delete a question' do
    sign_in(user)
    visit root_path
    click_on 'Create new question'

    fill_in 'Title', with: 'Some title'
    fill_in 'Content', with: 'Question to delete later'
    click_on 'Create'
    expect(page).to have_content 'Question successfully created'

    click_on 'Create new comment'
    fill_in 'Content', with: 'Answer to delete later'
    click_on 'Create'
    expect(page).to have_content 'Answer successfully created'

    click_on 'Sign out'
    sign_in(another)
    visit root_path

    click_on 'Delete stupid answer'
    expect(page).to have_content 'You are not allowed to delete this answer'
  end
end
