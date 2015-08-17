class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscrivable, polymorphic: true
  validates :user_id, presence: true
end
