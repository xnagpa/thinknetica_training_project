require 'rails_helper'
feature 'User can watch question and answers related', %q{
	 In order to ffind the answer to my question
	 As authed user or guest
	 I want to be able to be able to watch answers of each question
} do
	given(:user){FactoryGirl.create(:user)}

	scenario 'User or guest watches question and its answers' do 		
		FactoryGirl.create(:question_with_valid_answer)	
		
		visit questions_path		
		
		click_on 'Factory question'	

		expect(page).to have_content 'You suck!'	

	end	
	

end