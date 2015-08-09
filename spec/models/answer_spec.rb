require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:question) { FactoryGirl.create(:question, user: user) }
  let(:answer) { FactoryGirl.create(:answer, question: question, user: user) }
  let(:another_answer) { FactoryGirl.create(:another_answer, question: question, user: user) }
  let(:another_user) { FactoryGirl.create(:another_user) }
  let(:best_answer) { FactoryGirl.create(:best_answer, question: question, user: user) }

  it { expect(subject).to validate_presence_of(:content) }

  it { expect(subject).to validate_presence_of(:question_id) }

  it { expect(subject).to belong_to(:question) }

  it { expect(subject).to have_many(:attachments) }

  it { expect(subject).to accept_nested_attributes_for(:attachments) }

  it { expect(subject).to belong_to(:user) }

  it 'makes answer best' do
    answer.make_best
    expect(answer.best).to eq true
  end

  it 'It gets rid of previous best answer ' do
    expect(best_answer.best).to eq true
    another_answer.make_best
    best_answer.reload
    expect(another_answer.best).to eq true
    expect(best_answer.best).to eq false
  end
end
