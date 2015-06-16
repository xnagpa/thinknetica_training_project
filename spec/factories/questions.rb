FactoryGirl.define do

    factory :question do
    title 'Factory question'
    content 'Factory content'
    user

     factory :question_with_valid_answers do
       after(:create) do |question|
          create_list(:answer, 5, question: question)
     end
   end

    end
  #   factory :question_with_valid_answer do

  #     after(:create) do |question|
  #       create_list(:answer, 5, question: question)
  #     end
  #   end

  #   factory :question_with_invalid_answer do
  #     after(:create) do |question|
  #       create(:invalid_answer, 5, question: question)
  #     end
  #   end

  #   factory :question_answer_by_other_user do
  #     after(:create) do |question|
  #       create_list(:answer_made_by_other_user, 1, question: question, user: another)
  #     end
  #   end

  #    factory :question_with_one_answer do
  #     after(:create) do |question|
  #       create_list(:answer_made_by_other_user, 1, question: question, user: user)
  #     end
  #   end
  # end

  factory :invalid_question, class: 'Question' do
    title nil
    content nil
  end

  # factory :question_made_by_other_user, class: 'Question' do
  #   title 'Factory question made_by_other_user'
  #   content 'Factory content made_by_other_user'
    
  # end

  # factory :answer do
  #   content 'You suck!'
    
  # end

  # factory :answer_made_by_other_user, class: 'Answer' do
  #   content 'You suck!'    
  # end

   factory :invalid_answer, class: 'Answer' do
     content nil
   end
end
