class Question < ActiveRecord::Base

	has_many :answers,dependent: :destroy		
						
	validates :title, presence: true, length: {maximum:150}
	validates :content, presence: true	

end
