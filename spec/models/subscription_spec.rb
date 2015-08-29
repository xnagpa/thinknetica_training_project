require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { expect(subject).to belong_to(:subscrivable) }

  it { expect(subject).to validate_presence_of(:user_id) }
end
