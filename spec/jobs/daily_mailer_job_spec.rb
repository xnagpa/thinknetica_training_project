require 'rails_helper'

RSpec.describe DailyMailerJob, type: :job do
  it "sends daily email to users" do
    expect(DailyMailer).to receive(:new_answer)
    DailyMailerJob.perform_now
  end
end
