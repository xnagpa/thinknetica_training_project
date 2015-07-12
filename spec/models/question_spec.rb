require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:question) { FactoryGirl.create(:question_with_best_answer) }
  it {
    expect(subject).to validate_presence_of(:title)
  }
 

  it {
    expect(subject).to validate_presence_of(:title)
  }
 
  it {
    expect(subject).to validate_length_of(:title).is_at_most(150)
  }
 
  it {
    expect(subject).to validate_presence_of(:content)
  }
  
  it {
    expect(subject).to have_many(:answers).dependent(:destroy)
  }
  

  it {
    expect(subject).to have_many(:attachments).dependent(:destroy)
  }
  

  it {
    expect(subject).to accept_nested_attributes_for(:attachments)
  }
  

  it {
    expect(subject).to belong_to(:user)
  }
  

  it {
    expect(question.best_answer).to eq question.answers.where(best: true).first
  }
  

  # validates :title, presence: true
  # validates :title, length: {maximum:150}
  # validates :content, presence: true
end
