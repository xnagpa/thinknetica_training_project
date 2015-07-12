class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy, as: :attachable

  accepts_nested_attributes_for :attachments,reject_if: lambda { |a| a[:file].blank? }, allow_destroy: true

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :content, presence: true

  def best_answer
    answers.where(best: true).first
  end
end
