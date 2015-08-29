# Preview all emails at http://localhost:3000/rails/mailers/daily_mailer
class DailyMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/daily_mailer/digest
  def digest
    DailyMailer.digest(User.first)
  end

  def new_answer
    DailyMailer.new_answer(User.first, Answer.first)
  end
end
