require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(150) }
  it { should validate_presence_of(:content) }
  it { should have_many(:answers).dependent(:destroy) }

  # validates :title, presence: true
  # validates :title, length: {maximum:150}
  # validates :content, presence: true
end
