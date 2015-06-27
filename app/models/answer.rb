class Answer < ActiveRecord::Base
	belongs_to :user	
  belongs_to :question

  default_scope { order('best desc') } 

  validates :user_id,presence: true
  validates :content, presence: true
  validates :question_id, presence: true
end
