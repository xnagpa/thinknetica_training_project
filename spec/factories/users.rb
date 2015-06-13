FactoryGirl.define do
  sequence :email do |n|
  	"user#{n}@test.com"
  end

  factory :user do
  	id 1
    email	
    password '123332112'
    password_confirmation '123332112'
  end

  factory :another_user, class: 'User' do
  	id 2
    email	
    password '123332112'
    password_confirmation '123332112'
  end

end
