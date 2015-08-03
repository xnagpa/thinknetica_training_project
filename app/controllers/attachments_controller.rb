class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_attachment, only: [:destroy]
	
	respond_to :js

  def destroy
    respond_with(@attachment.destroy) if current_user.id == @attachment.attachable.user_id
  end

  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end
