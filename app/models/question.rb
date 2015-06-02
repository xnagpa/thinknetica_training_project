class Question < ActiveRecord::Base

	has_many :answers,dependent: :destroy		
						
	validates :title, presence: true
	validates :title, length: {maximum:150}
	validates :content, presence: true	

end
