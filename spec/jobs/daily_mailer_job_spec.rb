require 'rails_helper'

RSpec.describe DailyMailerJob, type: :job do
  it "sends daily email to users" do
    expect(DailyMailerJob).to receive(:send_daily_digest)
    DailyMailerJob.perform_now
  end
end
