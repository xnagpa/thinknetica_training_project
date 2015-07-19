module Votable
  def rating
    Vote.where(votable_id: id, votable_type: self.class.name).sum(:score)||0
  end

  def previous_vote(user)
   # previous_vote = Vote.where(user_id: user, votable_id: id, votable_type: self.class.name)
   previous_vote = Vote.where(votable: self)
    previous_vote.first
  end
end
