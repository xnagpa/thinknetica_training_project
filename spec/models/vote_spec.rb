require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { expect(subject).to belong_to(:votable) }

  it { expect(subject).to belong_to(:votable) }

  it { expect(subject).to validate_presence_of(:score) }

  it { expect(subject).to validate_presence_of(:user_id) }
end
