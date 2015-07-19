require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question_with_best_answer) }
  let!(:positive_vote) { FactoryGirl.create(:vote, user: user) }
  let!(:another_vote) { FactoryGirl.create(:vote, votable: question, user: user) }
  let!(:negative_vote) { FactoryGirl.create(:unvote, user: user) }

  it{ expect(subject).to validate_presence_of(:title) }

  it{ expect(subject).to validate_presence_of(:title) }

  it{ expect(subject).to validate_length_of(:title).is_at_most(150) }

  it{ expect(subject).to validate_presence_of(:content) }
  
  it{ expect(subject).to have_many(:answers).dependent(:destroy) }

  it{ expect(subject).to have_many(:attachments).dependent(:destroy) }

  it{ expect(subject).to accept_nested_attributes_for(:attachments) }
 
  it{ expect(subject).to belong_to(:user) }

  it 'returns best answer  ' do
    expect(question.best_answer).to eq question.answers.where(best: true).first
  end

  it 'can return previous vote of the user' do
    expect(question.previous_vote(user)).to eq (Vote.where(user_id: user, votable_id: question.id, votable_type: question.class.name).first)
  end

  it 'calculates the difference between negative and positive votes' do
    expect(question.rating).to eq (1)
  end

end
