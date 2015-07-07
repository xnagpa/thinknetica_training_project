require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:question) { FactoryGirl.create(:question_with_best_answer) }
  it 'validate_presence_of(:title) ' do
    expect(subject).to validate_presence_of(:title)
  end

  it 'validate_length_of(:title)' do
    expect(subject).to validate_presence_of(:title)
  end
  it 'should validate_length_of(:title)' do
    expect(subject).to validate_length_of(:title).is_at_most(150)
  end
  it 'should validate_presence_of(:content)' do
    expect(subject).to validate_presence_of(:content)
  end
  it 'should have_many(:answers)' do
    expect(subject).to have_many(:answers).dependent(:destroy)
  end

  it 'should have_many(:attachments)' do
    expect(subject).to have_many(:attachments).dependent(:destroy)
  end

   it 'accepts nested attributes ' do
   expect(subject).to accept_nested_attributes_for(:attachments)     
  end

  it 'should belong_to(:user)' do
    expect(subject).to belong_to(:user)
  end

  it 'should get best answer' do
    expect(question.best_answer).to eq question.answers.where(best: true).first
  end

  # validates :title, presence: true
  # validates :title, length: {maximum:150}
  # validates :content, presence: true
end
