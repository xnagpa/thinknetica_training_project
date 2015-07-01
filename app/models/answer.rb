class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  default_scope { order('best desc') }

  validates :user_id, presence: true
  validates :content, presence: true
  validates :question_id, presence: true

  def make_best
    
  	best_answer = question.best_answer  	
    
  	best_answer.update(best: false) unless best_answer.blank?
    
    update(best: true) unless self==best_answer
       
  end

  

end
