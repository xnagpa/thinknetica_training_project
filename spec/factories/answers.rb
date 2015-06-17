FactoryGirl.define do
  
    factory :answer do	 
      association :user
      association :question  
	    content 'You are beautiful!' 	   
    end
 end