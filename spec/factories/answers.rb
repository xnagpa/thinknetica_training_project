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

     factory :best_answer  do   
      association :user
      association :question  
       content 'You are handsome!'   
       best true  
    end
  end
end