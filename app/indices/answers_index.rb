ThinkingSphinx::Index.define :answer, with: :active_record do
  # fileds
  indexes content
  indexes user.email, as: :author, sortable: true

  # attributes
  has user_id, created_at, updated_at
end
