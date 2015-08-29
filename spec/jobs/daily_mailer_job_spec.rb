require 'rails_helper'

RSpec.describe DailyMailerJob, type: :job do
  let!(:user) { FactoryGirl.create(:user) }
  it 'sends daily email to users' do
    expect(DailyMailer).to receive(:digest).and_call_original
    DailyMailerJob.perform_now
  end
end
