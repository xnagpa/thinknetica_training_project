class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:destroy]
  before_action :find_commentable, only: [:create]

  respond_to :html,:js
  authorize_resource
	def create	
   
      @comment = @commentable.comments.new(comment_params)
   	  @comment.user = current_user  
    #сравниваем по id  присв по объектам
      respond_with(@comment) if @comment.save
   
  end

  def destroy
    respond_with(@comment.destroy) 
  end  

	def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    klass, id = request.path.scan(/(?<=\/)(.*?)(?=\/)/)
    @commentable = klass[0].singularize.classify.constantize.find(id[0].to_i)
  end

end
