require_relative 'acceptance_helper'

feature 'User creates question and attaches file', '
   In order to get rid of attachment
   As authed user
   I want to be able delete it

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:another_user) { FactoryGirl.create(:another_user) }

  given!(:attachment) { FactoryGirl.create(:attachment) }
  given!(:question_with_attachments) { FactoryGirl.create(:question_with_attachments, user: user) }

  scenario 'Authed deletes attachment', js: true do
    sign_in(user)

    visit question_path(question_with_attachments)

    expect(page).to have_content 'spec_helper.rb'

    click_on 'Destroy attachment'

    expect(page).not_to have_content 'spec_helper.rb'
  end

  scenario 'Non-author doesnt see delete attachment link', js: true do
    sign_in(another_user)

    visit question_path(question_with_attachments)
    expect(page).not_to have_content 'Destroy attachment'
  end
end
