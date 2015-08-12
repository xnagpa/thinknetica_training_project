class SingleQuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at,:short_title
  has_many :comments
  has_many :attachments

  def short_title
    object.title.truncate(10)
  end
end
