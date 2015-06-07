FactoryGirl.define do

  factory :question do
    title "Factory question"
    content "Factory content"

    factory :question_with_valid_answer do
      after(:create) do |question|
      create_list(:answer, 5,question: question)
      end    	
    end

     factory :question_with_invalid_answer do
      after(:create) do |question|
      create(:invalid_answer,5, question: question)
      end    	
    end


  end

  factory :invalid_question, class: 'Question' do
    title nil
    content nil
  end

  
factory :answer do
  content 'You suck!'

end

  
factory :invalid_answer,class: 'Answer' do
  content nil
end



 
end
