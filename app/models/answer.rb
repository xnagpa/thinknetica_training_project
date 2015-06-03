class Answer < ActiveRecord::Base
	belongs_to :question
	
	validates :content, presence: true
	validates :question, presence:true

	
end
