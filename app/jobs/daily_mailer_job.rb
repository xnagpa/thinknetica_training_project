class DailyMailerJob < ActiveJob::Base
  queue_as :default

  def DailyMailerJob.send_daily_digest
    User.find_each.each do |user|
     DailyMailer.digest(user).deliver_later
    end
  end

  def perform
    DailyMailerJob.send_daily_digest
  end
end
