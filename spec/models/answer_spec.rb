require 'rails_helper'

RSpec.describe Answer, type: :model do
	let!(:answer) { FactoryGirl.create(:answer) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:question_id) }
  it { should belong_to(:question) }
  it { should belong_to(:user) }

  it 'could make answer best' do 
  	answer.make_best
  	answer.best.should == true  		
  end


end
