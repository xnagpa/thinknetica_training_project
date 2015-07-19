require 'rails_helper'

RSpec.describe User do
  it { expect(subject).to validate_presence_of :email }
  it { expect(subject).to validate_presence_of :password }
end
