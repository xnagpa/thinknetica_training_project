require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { expect(subject).to belong_to(:commentable) }
  it { expect(subject).to validate_presence_of :content }
  it { expect(subject).to validate_presence_of :user_id }
  it { expect(subject).to validate_presence_of :commentable_id }
  it { expect(subject).to validate_presence_of :commentable_type }
end
