require_relative 'acceptance_helper'


feature 'Anybody can search', '
   In order to find the info
   As guest or user, whatever
   I want to be able to search from any page

' do
given!(:user){ FactoryGirl.create(:user)}
given!(:question){ FactoryGirl.create(:question, content:"Nothing else matters", user: user)}
given!(:answer){ FactoryGirl.create(:answer, content:"Nothing to be afraid of", user:user)}
given!(:comment){ FactoryGirl.create(:comment, content:"Nothing is important, lol", user: user)}
ThinkingSphinx::Test.init
ThinkingSphinx::Test.start
ThinkingSphinx::Test.index


scenario 'User searches all' do
ThinkingSphinx::Test.run do
  sign_in(user)
  visit questions_path
  expect(page).to have_content('Search')
  within('.search_form') do
    fill_in 'search_field', with: "Nothing"

    click_on 'Search'
  end
  expect(page).to have_content('Search results')
  expect(page).to have_content("Nothing")

end
end



end
