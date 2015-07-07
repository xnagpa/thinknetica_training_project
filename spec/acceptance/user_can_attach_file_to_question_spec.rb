require_relative 'acceptance_helper'

feature 'User creates question and attaches file', '
   In order to get answer from other users
   As authed user
   I want to be able to be able to ask questions with file exapmles

' do

  given(:user) { FactoryGirl.create(:user) }

  scenario 'Authed user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Create new question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Content', with: 'texttext'
    attach_file 'File1', "#{Rails.root}/spec/spec_helper.rb"
    attach_file 'File2', "#{Rails.root}/spec/spec_helper.rb"
    attach_file 'File3', "#{Rails.root}/spec/spec_helper.rb"
    attach_file 'File4', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Save'
    
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb',count:3
  end

  
end
