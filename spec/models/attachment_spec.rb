require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it {
    expect(subject).to belong_to(:attachable)
  }
  
end
