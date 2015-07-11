class AttachmentsController < ApplicationController
	before_action :extract_attachment_id, only: [:destroy]

	def destroy
		@attachable = @attachment.attachable
		@attachment.destroy if current_user.id == @attachment.attachable.user.id  

	end

	def extract_attachment_id
    @attachment = Attachment.find(params[:id])
  end
end
