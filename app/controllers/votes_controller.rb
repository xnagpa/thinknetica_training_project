class VotesController < ApplicationController
  before_action :find_vote, only: [:destroy]

  def create

    temp = request.path
    klass, id = temp.scan(/(?<=\/)(.*?)(?=\/)/)
    @votable = klass[0].singularize.classify.constantize.find(id[0].to_i)
      
    

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
