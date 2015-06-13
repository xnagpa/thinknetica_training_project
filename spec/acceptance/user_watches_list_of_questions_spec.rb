require 'rails_helper'
feature 'User watches list of questions', %q{
	 In order to find the answer 
	 As user or guest
	 I want to be able see a list of all questions ever created 
} do
	#given(:user){FactoryGirl.create(:user)}

	scenario 'User or guest visits the root ' do 
		
		#sign_in(user)
		FactoryGirl.create(:question_with_valid_answer)
		visit root_path

		expect(page).to have_content 'Factory question'
		expect(current_path).to eq root_path

	end	
end