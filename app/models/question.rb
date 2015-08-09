
class Question < ActiveRecord::Base
  include Votable
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy, as: :attachable
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :votes, dependent: :destroy, as: :votable

  #pagination
  self.per_page = 5

  accepts_nested_attributes_for :attachments, reject_if: ->(a) { a[:file].blank? }, allow_destroy: true

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :content, presence: true

  def best_answer
    answers.where(best: true).first
  end
end
