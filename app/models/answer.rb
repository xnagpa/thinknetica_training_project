
class Answer < ActiveRecord::Base
  include Votable
  belongs_to :user
  belongs_to :question
  has_many :attachments, dependent: :destroy, as: :attachable
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :votes, dependent: :destroy, as: :votable

  accepts_nested_attributes_for :attachments, reject_if: ->(a) { a[:file].blank? }, allow_destroy: true

  default_scope { order('best desc') }

  validates :user_id, presence: true
  validates :content, presence: true
  validates :question_id, presence: true

  def make_best
    best_answer = question.best_answer

    best_answer.update(best: false) unless best_answer.blank?

    update(best: true) unless self == best_answer
  end
end
