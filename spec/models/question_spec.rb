require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question_with_best_answer) }
  let!(:positive_vote) { FactoryGirl.create(:vote, user: user) }
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

  it do
    expect(question.best_answer).to eq question.answers.where(best: true).first
  end

  it do
    expect(question.positive_votes).to eq Vote.where(votable_id: question.id, votable_type: question.class.name).sum(:thumb_up)
  end

  it do
    expect(question.negative_votes).to eq Vote.where(votable_id: question.id, votable_type: question.class.name).sum(:thumb_down)
  end

  it do
    expect(question.previous_vote(user)).to eq (Vote.where(user_id: user, votable_id: question.id, votable_type: question.class.name))
  end

  it do
    expect(question.rating).to eq (question.positive_votes - question.negative_votes)
  end

  it do
    expect(question.votes_are_different?(positive_vote, negative_vote)).to eq (true)
  end

  it do
    expect(question.can_i_insert_this_vote?(negative_vote, user)).to eq (true)
  end

  # validates :title, presence: true
  # validates :title, length: {maximum:150}
  # validates :content, presence: true
end
