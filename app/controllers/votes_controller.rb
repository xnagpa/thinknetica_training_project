class VotesController < ApplicationController

	def create
	
		klass = votable_params[:votable_type]
		@votable = klass.singularize.classify.constantize.find(votable_params[:id])		
		@vote = @votable.votes.new(vote_params)

		if @votable.user != current_user && user_signed_in?
			if @votable.can_i_insert_this_vote?(@vote, current_user)
				
				@vote.user = current_user
			  @vote.save
			else 
				 flash[:notice] = 'You cant vote same way twice!'
			end	 
	  end

    
	end



	 def find_vote
    @vote = Attachment.find(params[:id])
  end

   def vote_params
    params.require(:vote).permit(:thumb_up, :thumb_down)  
   end

   def votable_params
   	  params.require(:votable).permit(:id,  :votable_type)
   end 

end
