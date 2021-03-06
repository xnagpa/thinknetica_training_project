class NewAnswerNotifierJob < ActiveJob::Base
  queue_as :default

  def perform(question, answer)
    list = Subscription.where(subscrivable: question)
    list.each do |subscr|
      DailyMailer.new_answer(subscr.user, answer).deliver_later
    end
  end
end
