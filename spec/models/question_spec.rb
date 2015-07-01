require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:question) { FactoryGirl.create(:question_with_best_answer) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(150) }
  it { should validate_presence_of(:content) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to(:user) }

  it 'should get best answer' do  	
  	question.best_answer == question.answers.where({question:self, best:true}).first  
  end

  # validates :title, presence: true
  # validates :title, length: {maximum:150}
  # validates :content, presence: true
end
