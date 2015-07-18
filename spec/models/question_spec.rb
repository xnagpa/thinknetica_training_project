require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question_with_best_answer) }
  let!(:positive_vote) { FactoryGirl.create(:vote, user: user) }
  let!(:another_vote) { FactoryGirl.create(:vote, votable: question, user: user) }
  let!(:negative_vote) { FactoryGirl.create(:unvote) }

  it do
    expect(subject).to validate_presence_of(:title)
  end

  it do
    expect(subject).to validate_presence_of(:title)
  end

  it do
    expect(subject).to validate_length_of(:title).is_at_most(150)
  end

  it do
    expect(subject).to validate_presence_of(:content)
  end

  it do
    expect(subject).to have_many(:answers).dependent(:destroy)
  end

  it do
    expect(subject).to have_many(:attachments).dependent(:destroy)
  end

  it do
    expect(subject).to accept_nested_attributes_for(:attachments)
  end

  it do
    expect(subject).to belong_to(:user)
  end

  it 'returns best answer  ' do
    expect(question.best_answer).to eq question.answers.where(best: true).first
  end

  it 'can return previous vote of the user' do
    expect(question.previous_vote(user)).to eq (Vote.where(user_id: user, votable_id: question.id, votable_type: question.class.name).first)
  end

  it 'calculates the difference between negative and positive votes' do
    expect(question.rating).to eq (Vote.where(votable_id: question.id, votable_type: question.class.name).sum(:score))
  end

  # validates :title, presence: true
  # validates :title, length: {maximum:150}
  # validates :content, presence: true
end
