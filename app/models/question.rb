class Question < ActiveRecord::Base
	has_many :comments,class_name: "Question",
						dependent: :destroy,
						foreign_key: "parent_question_id"
						
	belongs_to :parent_question, class_name: "Question"	

	validates :title, presence: true
	validates :title, length: {maximum:150}
	validates :content, presence: true
	validates :parent_question_id, presence: true


end
