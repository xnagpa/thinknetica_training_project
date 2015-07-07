require_relative 'acceptance_helper'

feature 'User creates answer and attaches file', '
   In order to be a captain obvious
   As authed user
   I want to be able to be able to leave answer with file exapmles

' do

  given(:user) { FactoryGirl.create(:user) }
  given(:question) { FactoryGirl.create(:question, user: user) }

  scenario 'Authed user creates question with attachment', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'Test comment and some crap'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Save'

    within '.answers' do
     expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end


  scenario 'Authed user creates question with many attachments', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'Test comment and some crap'
    attach_file 'File1', "#{Rails.root}/spec/spec_helper.rb"
    attach_file 'File2', "#{Rails.root}/spec/spec_helper.rb"
    attach_file 'File3', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Save'

    within '.answers' do
     expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb',count:3
    end
  end


  
end
