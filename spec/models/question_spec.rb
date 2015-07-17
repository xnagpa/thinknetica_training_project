require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question_with_best_answer) }
  let!(:positive_vote) { FactoryGirl.create(:vote, user:user) }
  let!(:negative_vote) { FactoryGirl.create(:unvote) }
  

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

  it {
    expect(question.positive_votes).to eq Vote.where(votable_id: question.id, votable_type: question.class.name).sum(:thumb_up)
  }

  it {
    expect(question.negative_votes).to eq Vote.where(votable_id: question.id, votable_type: question.class.name).sum(:thumb_down)
  }

  it {
    expect(question.previous_vote(user)).to eq (Vote.where(user_id: user, votable_id: question.id, votable_type: question.class.name))
  }

  it {
    expect(question.rating).to eq (question.positive_votes-question.negative_votes)
  }

  it {
    expect(question.votes_are_different?(positive_vote,negative_vote)).to eq (true)
  }

  it {
    expect(question.can_i_insert_this_vote?(negative_vote,user)).to eq (true)
  }
  
  
 

  # validates :title, presence: true
  # validates :title, length: {maximum:150}
  # validates :content, presence: true
end
