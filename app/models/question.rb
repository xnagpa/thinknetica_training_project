class Question < ActiveRecord::Base
	belongs_to :user
  has_many :answers, dependent: :destroy

  validates :user_id,presence: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :content, presence: true
end
