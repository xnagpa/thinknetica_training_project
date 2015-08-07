class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_vote, only: [:destroy]
  before_action :find_votable, only: [:create]

  respond_to :html,:js

  authorize_resource except: :create

  def create     
    @vote = @votable.votes.new(vote_params)
    authorize! :create, @vote
    previous_vote = @votable.previous_vote(current_user)

      if previous_vote.nil? || previous_vote.score != @vote.score
        @vote.user = current_user        
        @vote.save
      end
      
   
  end

  def destroy     
    respond_with(@vote.destroy) 
  end

  def find_vote
    @vote = Vote.find(params[:id])
  end

  def find_votable
    klass, id = request.path.scan(/(?<=\/)(.*?)(?=\/)/)
    @votable = klass[0].singularize.classify.constantize.find(id[0].to_i)
  end

  def vote_params
    params.require(:vote).permit(:score)
  end
end
