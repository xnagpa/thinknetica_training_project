require 'rails_helper'
# ask instances
# capybara-email
# rake - middleware, framework, everything from the scratch
# sinatra - simple site, landing page.
# padrino - sinatra+stuff
# what should I know about rake? (How to create rake tasks, *cronjobs, *dataload)
# gem
# Angular 2 month 1.6 Free updates
# 18 000 individual
# Access for all lessons

RSpec.describe NewAnswerNotifierJob, type: :job do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:question) { FactoryGirl.create(:question, user: user) }
  let!(:answer) { FactoryGirl.create(:answer, question: question, user: user) }
  let!(:subscription) { FactoryGirl.create(:subscription, subscrivable: question, user: user) }

  it 'sends answer in email to all subscribers' do
    expect(DailyMailer).to receive(:new_answer).and_call_original
    NewAnswerNotifierJob.perform_now(question, answer)
  end
end
