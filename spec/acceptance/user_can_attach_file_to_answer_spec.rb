require_relative 'acceptance_helper'

feature 'User creates answer and attaches file', '
   In order to be a captain obvious
   As authed user
   I want to be able to be able to leave answer with file exapmles

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question, user: user) }

  scenario 'Authed user creates answer two attachments', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'answer[content]', with: 'Test answer'
    click_on 'add attachment'
    files = all("input[type='file']")
    files[0].set('#{Rails.root}/spec/spec_helper.rb')
    files[1].set('#{Rails.root}/spec/rails_helper.rb')

    click_on 'Save'

    within '.answers' do
      expect(page).to have_content('spec_helper.rb', count: 1)
      expect(page).to have_content('rails_helper.rb', count: 1)
    end
  end

  scenario 'Authed user creates answer with attachment, ant then deletes the attachment', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'answer[content]', with: 'Test answer'
    files = all("input[type='file']")
    files[0].set('#{Rails.root}/spec/spec_helper.rb')

    click_on 'remove file'
    click_on 'Save'

    within '.answers' do
      expect(page).not_to have_content('spec_helper.rb')
      expect(page).not_to have_content('Test answer')
    end
  end
end
