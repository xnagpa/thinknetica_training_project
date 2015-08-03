require_relative 'acceptance_helper'

feature 'User can vote for the answer', '
   In order for other users to get the best answer
   As authed user
   I want to be able to vote

' do
  given!(:author) { FactoryGirl.create(:user) }
  given!(:non_author) { FactoryGirl.create(:another_user) }

  given!(:question) { FactoryGirl.create(:question, user: author) }
  given!(:answer) { FactoryGirl.create(:answer,  question:  question, user: author) }

  given(:another_answer) { FactoryGirl.create(:another_answer,  question:  question, user: user) }

  # Аутентифицированный пользователь может голосовать за понравившийся вопрос/ответ
  # Пользователь не может голосовать за свой вопрос/ответ
  # Пользователь может проголосовать "за" или "против" конкретного вопроса/ответа
  # только один раз (нельзя голосовать 2 раза подряд "за" или "против")
  # Пользователь может отменить свое решение и после этого переголосовать.
  # У вопроса/ответа должен выводиться результирующий рейтинг (разница между голосами
  # "за" и "против")

  scenario 'Authed user votes positively', js: true do
    sign_in(non_author)

    visit question_path(question)
    scores = page.all('.score')
    scores[1].click
    answers = page.all('.answer .rating')

    within answers[0] do
      expect(page).to have_content 'Rating: 1'
    end
  end

  scenario 'Authed user votes negatively', js: true do
    sign_in(non_author)

    visit question_path(question)
    unscores = page.all('.unscore')
    unscores[1].click
    answers = page.all('.answer .rating')

    within answers[0] do
      expect(page).to have_content 'Rating: -1'
    end
  end

  scenario 'Author can\'t vote for his own answer', js: true do
    sign_in(author)

    visit question_path(question)
    expect(page).to have_content 'No votes for your own stuff! '
  end

  scenario 'User can change his mind and revote', js: true do
    sign_in(non_author)

    visit question_path(question)
    scores = page.all('.score')
    scores[1].click
    answers = page.all('.answer .rating')
    save_and_open_page
    within answers[0] do
      expect(page).to have_content 'Rating: 1'
    end

    click_on 'Revote'
    answers = page.all('.answer .rating')

    within answers[0] do
      expect(page).to have_content 'Rating: 0'
    end
  end

  scenario 'Anybody can see rating even without any votes', js: true do
    visit question_path(question)
    expect(page).to have_content 'Rating: 0'
  end

  scenario 'User can vote only once for one question', js: true do
    sign_in(non_author)

    visit question_path(question)

    scores = page.all('.score')

    scores[1].click

    expect(page).not_to have_content '.score'
  end
end
