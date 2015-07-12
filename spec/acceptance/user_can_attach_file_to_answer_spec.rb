require_relative 'acceptance_helper'

feature 'User creates answer and attaches file', '
   In order to be a captain obvious
   As authed user
   I want to be able to be able to leave answer with file exapmles

' do
  given(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question, user: user) }

  scenario 'Authed user creates answer with attachment', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'answer[content]', with: 'Test answer'
    files = all("input[type='file']")
    files[0].set('#{Rails.root}/spec/spec_helper.rb')
    click_on 'Save'

    within '.answers' do
      expect(page).to have_content('spec_helper.rb')
    end
  end

  scenario 'Authed user creates answer two attachments', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'answer[content]', with: 'Test answer'
    click_on 'add attachment'
    files = all("input[type='file']")
    files[0].set('#{Rails.root}/spec/spec_helper.rb')
    files[1].set('#{Rails.root}/spec/spec_helper.rb')

    click_on 'Save'

    within '.answers' do
      expect(page).to have_content('spec_helper.rb', count: 2)
    end
  end

  # given(:user) { FactoryGirl.create(:user) }
  #   given(:user_with_questions) { FactoryGirl.create(:user_with_question) }
  #   given!(:question) { FactoryGirl.create(:question, user: user) }

  #   scenario 'User attaches one file to existing question', js: true do
  #     sign_in(user)
  #     visit question_path(question)
  #       click_on 'Edit stupid question'

  #         fill_in 'question[content]', with: 'Test edit question'
  #         first(".add_fields").click
  #         files = all("input[type='file']")
  #         files[0].set('#{Rails.root}/spec/spec_helper.rb')
  #         submits =all("input[name='commit']")
  #         submits[0].click
  #         save_and_open_page
  #         expect(page).to have_content("spec_helper.rb");
  #   end

  # scenario 'Authed user creates question with many attachments', js: true do
  #   sign_in(user)
  #   visit question_path(question)
  #   fill_in 'Your answer', with: 'Test comment and some crap'
  #   attach_file 'File1', "#{Rails.root}/spec/spec_helper.rb"
  #   attach_file 'File2', "#{Rails.root}/spec/spec_helper.rb"
  #   attach_file 'File3', "#{Rails.root}/spec/spec_helper.rb"

  #   click_on 'Save'

  #   within '.answers' do
  #    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb',count:3
  #   end
  # end
end
