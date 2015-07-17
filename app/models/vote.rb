class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :votable, polymorphic: true
	#validates :thumb_up, unless: :thumb_down?
	#validates :thumb_down, unless: :thumb_up?
	validates :thumb_up, presence: true
	validates :thumb_down, presence: true

	attr_reader :rating
	attr_reader :positive_votes
	attr_reader :negative_votes

	

end
