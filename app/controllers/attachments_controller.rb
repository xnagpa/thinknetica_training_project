class AttachmentsController < ApplicationController
  before_action :find_attachment, only: [:destroy]

  def destroy
    @attachment.destroy if current_user.id == @attachment.attachable.user_id
  end

  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end
