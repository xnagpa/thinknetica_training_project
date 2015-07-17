require 'rails_helper'

RSpec.describe Vote, type: :model do
  it {
    expect(subject).to belong_to(:votable)
  }

  it {
    expect(subject).to belong_to(:votable)
  }

   it {
    expect(subject).to validate_presence_of(:thumb_up)
  }

    it {
    expect(subject).to validate_presence_of(:thumb_down)
  }

end
