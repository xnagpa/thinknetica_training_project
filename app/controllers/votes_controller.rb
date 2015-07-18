class VotesController < ApplicationController
  before_action :find_vote, only: [:destroy]

  def create
    case request.path
    when /answers\/\d+/

      klass = 'Answer'
      temp = /answers\/\d+/.match(request.path)
      index_of_slash  = temp.to_s.index('/')
      id = temp.to_s[index_of_slash + 1..-1]
      @votable = klass.singularize.classify.constantize.find(id.to_i)

    when /questions\/\d+/
      klass = 'Question'
      temp = /questions\/\d+/.match(request.path)
      index_of_slash  = temp.to_s.index('/')
      id = temp.to_s[index_of_slash + 1..-1]
      @votable = klass.singularize.classify.constantize.find(id.to_i)

   end

    @vote = @votable.votes.new(vote_params)

    if @votable.user != current_user && user_signed_in?
      previous_vote = @votable.previous_vote(current_user)
      if previous_vote.nil? || previous_vote.score != @vote.score
        @vote.user = current_user
        @vote.save
     end

    end
  end

  def destroy
    @vote.destroy if current_user.id == @vote.user_id
  end

  def find_vote
    @vote = Vote.find(params[:id])
 end

  def vote_params
    params.require(:vote).permit(:score)
  end
end
