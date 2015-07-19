module Votable
  def rating
    plus = positive_votes
    minus = negative_votes
    plus - minus
 end

  def positive_votes
    positive_votes = Vote.where(votable_id: id, votable_type: self.class.name).sum(:thumb_up)
  end

  def negative_votes
    positive_votes = Vote.where(votable_id: id, votable_type: self.class.name).sum(:thumb_down)
  end

  def previous_vote(user)
    previous_vote = Vote.where(user_id: user, votable_id: id, votable_type: self.class.name)
  end

  def votes_are_different?(vote1, vote2)
    vote1.thumb_up != vote2.thumb_up || vote1.thumb_down != vote2.thumb_down
  end

  def can_i_insert_this_vote?(vote, user)
    prev_vote = previous_vote(user)
    if prev_vote.empty?
      return true
    elsif votes_are_different?(prev_vote.first, vote)

      prev_vote.first.destroy
      return true
    else
      return false
    end
  end
end
