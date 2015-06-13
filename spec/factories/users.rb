FactoryGirl.define do
  sequence :email do |n|
  	"user#{n}@test.com"
  end

  factory :user do
    email
    password '123332112'
    password_confirmation '123332112'
  end

end
