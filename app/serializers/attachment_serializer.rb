class AttachmentSerializer < ActiveModel::Serializer
  # what should I do if I want both Question-Answers and Question-Comments?
  attributes :url
  def url
    object.file.url
  end
end
