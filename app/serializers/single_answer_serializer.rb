class SingleAnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :updated_at
  has_many :attachments
  has_many :comments
end
