FactoryGirl.define do
  factory :comment do
    content 'MyString'
    commentable_type 'Question'
    commentable_id 1
  end
end
