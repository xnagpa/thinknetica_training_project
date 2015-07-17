FactoryGirl.define do
  factory :vote do
    thumb_up 1
	  thumb_down 0
  end

  factory :unvote, class: 'Vote' do
    thumb_up 0
	  thumb_down 1
  end
end
