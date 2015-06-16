FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do    
    email
    password '123332112'
    password_confirmation '123332112'

    factory :another_user do
      email
      password '12333211244'
      password_confirmation '12333211244'
    end

    factory :user_with_question do
        after(:create) do |user|
         create_list(:question, 3, user: user)         
       end
     end

     factory :user_with_answers do
        after(:create) do |user|
         create_list(:answer, 3, user: user)         
       end
     end
    
  
  end
end
