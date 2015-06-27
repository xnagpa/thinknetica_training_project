FactoryGirl.define do
  
  factory :answer do	 
    association :user
    association :question
    content 'You are beautiful!'
    factory :another_answer  do	 
      association :user
      association :question  
	     content 'You are handsome!' 	   
    end
  end
end