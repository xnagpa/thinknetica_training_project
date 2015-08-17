class NewAnswerNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(question, answer)
    NewAnswerNotifierJob.mail_to_subscribers_of(question, answer)
  end

  def NewAnswerNotifierJob.mail_to_subscribers_of(question, answer)
    list = Subscription.where( subscrivable:question )
    list.each do |subscr|
      byebug
     DailyMailer.new_answer(subscr.user, answer).deliver_later
    end
  end
end
