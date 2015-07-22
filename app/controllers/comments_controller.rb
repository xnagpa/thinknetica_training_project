class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]

	def create	

		klass, id = request.path.scan(/(?<=\/)(.*?)(?=\/)/)
    @commentable = klass[0].singularize.classify.constantize.find(id[0].to_i)
    @comment = @commentable.comments.new(comment_params)
 
    if user_signed_in? 
    	@comment.user_id = current_user.id  

      @comment.save
    end
  end

  def destroy
    @comment.destroy if @comment.user_id = current_user.id  
  end  

	def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
