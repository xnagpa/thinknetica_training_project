class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  default_scope { order('best desc') }

  validates :user_id, presence: true
  validates :content, presence: true
  validates :question_id, presence: true

  def self.get_rid_of_the_old_best_answer(question)
  	best_answer = get_old_best_answer(question)  	
  	best_answer.update(best: false) unless best_answer.blank?
  end

  def self.get_old_best_answer(question)
  	best_answer = Answer.where({question:question, best:true}).first    	
  end


end
