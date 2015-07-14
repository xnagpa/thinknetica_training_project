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


  scenario 'Authed user votes positively' do
    sign_in(non_author)

    visit question_path(question)
    thumb_ups = page.all('.thumb_up')
    thumb_ups[0].click

    within '.answer' do
    	expect(page).to have_content 'rating: 1'
  	end    
  end

   scenario 'Authed user votes negatively' do
    sign_in(non_author)

    visit question_path(question)
    thumb_downs = page.all('.thumb_down')
    thumb_downs[0].click

    within '.answer' do
    	expect(page).to have_content 'rating: -1'
  	end    
  end

  scenario 'Author can\'t vote for his own answer' do
    sign_in(author)

    visit question_path(question)
    thumb_downs = page.all('.thumb_down')
    thumb_downs[0].click

    within '.answer' do
    	expect(page).to have_content 'You can\'t vote for your own answer!'
  	end    
  end

   scenario 'User can change his mind and revote' do

   	sign_in(non_author)
   	
    visit question_path(question)
    thumb_downs = page.all('.thumb_down')
    thumb_ups = page.all('.thumb_up')
    thumb_downs[0].click
    
    within '.answer' do
    	expect(page).to have_content 'rating: -1'
  	end   

  	click_on "Revote" 
  	within '.answer' do
    	expect(page).to have_content 'rating: 0'
  	end    

  	thumb_ups[0].click
    within '.answer' do
    	expect(page).to have_content 'rating: 1'
  	end    
   
  end


   scenario 'User can vote only once for one question' do

   	 sign_in(non_author)

    visit question_path(question)
    thumb_downs = page.all('.thumb_down')
    thumb_downs[0].click

    within '.answer' do
    	expect(page).to have_content 'rating: -1'
  	end    

  	thumb_downs[0].click
    within '.answer' do
    	expect(page).to have_content 'rating: -1'
  	end    
   
  end





  
end