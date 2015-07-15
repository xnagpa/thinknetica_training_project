class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy, as: :attachable
  has_many :votes, dependent: :destroy, as: :votable

  accepts_nested_attributes_for :attachments,reject_if: lambda { |a| a[:file].blank? }, allow_destroy: true

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :content, presence: true

  def best_answer
    answers.where(best: true).first
  end

  def rating
    plus = positive_votes 
    minus= negative_votes
    plus - minus    
  end 

  def positive_votes
    positive_votes= Vote.where(votable_id: self.id, votable_type: self.class.name).sum(:thumb_up)

  end

  def negative_votes
      positive_votes= Vote.where(votable_id: self.id, votable_type: self.class.name).sum(:thumb_down)
  end

end
