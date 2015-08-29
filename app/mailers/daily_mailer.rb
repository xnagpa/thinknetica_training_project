class DailyMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.daily_mailer.digest.subject
  #
  def digest(user)
    #  @today_questions = Question.where(created_at: (Time.now - 1.day)..Time.now)
    @today_questions = Question.where(created_at: (Time.now - 1.day)..Time.now)
    mail to: user.email
  end

  def new_answer(user, answer)
    #  @today_questions = Question.where(created_at: (Time.now - 1.day)..Time.now)
    @answer = answer
    mail to: user.email
  end
end
