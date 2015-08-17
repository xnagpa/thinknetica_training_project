require 'rails_helper'

RSpec.describe NewAnswerNotifierJob, type: :job do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question, user: user) }
  let!(:answer) { FactoryGirl.create(:answer, question: question, user: user) }
  let!(:subscription) { FactoryGirl.create(:subscription, subscrivable: question, user: user) }

  it "sends answer in email to all subscribers" do
    expect(DailyMailer).to receive(:digest)
    NewAnswerNotifierJob.perform_now( question, answer)
  end
end
