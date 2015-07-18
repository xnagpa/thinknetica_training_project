class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true
  # validates :score, unless: :unscore?
  # validates :unscore, unless: :score?
  validates :score, presence: true
end
