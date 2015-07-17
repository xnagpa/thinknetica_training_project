require 'rails_helper'

RSpec.describe Vote, type: :model do
  it do
    expect(subject).to belong_to(:votable)
  end

  it do
    expect(subject).to belong_to(:votable)
  end

  it do
    expect(subject).to validate_presence_of(:thumb_up)
  end

  it do
    expect(subject).to validate_presence_of(:thumb_down)
  end
end
